class Person < ActiveRecord::Base
  belongs_to :user
  has_many :items, :as => :owner
  has_many :item_requests, :as => :requester
  has_many :item_gifts, :as => :gifter, :class_name => "ItemRequest"
  has_many :people_network_requests
  has_many :received_people_network_requests, :class_name => "PeopleNetworkRequest", :foreign_key => "trusted_person_id"
  has_many :people_networks
  has_many :received_people_networks, :class_name => "PeopleNetwork", :foreign_key => "trusted_person_id"

  has_many :activity_logs, :as => :primary
  has_many :activity_logs_as_secondary, :as => :secondary, :class_name => "ActivityLog"

  has_many :event_logs, :as => :primary
  has_many :event_logs_as_secondary, :as => :secondary, :class_name => "EventLog"

  has_many :event_entities, :as => :entity
  has_many :related_event_logs, :through => :event_entities, :source => :event_log
  
  validates_presence_of :user_id, :name

  def belongs_to?(some_user)
    user == some_user
  end
  
  def trusts?(other_person)
    self.people_networks.involves_as_trusted_person(other_person).first
  end
  
  def all_item_requests
    ItemRequest.involves(self)
  end

  def active_item_requests
    ItemRequest.involves(self).active.order("created_at DESC")
  end

  def unanswered_requests(requester = nil)
    if requester
      ItemRequest.unanswered.involves(self).involves(requester)
    else
      ItemRequest.unanswered.involves(self)
    end
  end
  
  def avatar(avatar_size = nil)
    self.user.avatar(avatar_size)
  end

  def first_name
    name.split.first
  end

  def news_feed
    # trying to replicate following query using AREL
    # SELECT
    # event_log_id, SUM(trusted_relationship_value) as total_relationship_value
    # FROM
    # event_entities ee
    # INNER JOIN
    #      (SELECT trusted_person_id, 4 as trusted_relationship_value FROM people_networks WHERE person_id = XYZ) network
    #      ON ee.entity_id = network.trusted_person_id AND ee.entity_type = 'Person'
    # GROUP BY ee.event_log_id
    # ORDER BY ee.created_at DESC
    # LIMIT 25
  
    ee = Arel::Table.new(EventEntity.table_name.to_sym)
    pn = Arel::Table.new(PeopleNetwork.table_name.to_sym)

    pn_network = pn.project(pn[:trusted_person_id], Arel.sql("4 as trusted_relationship_value")).where(pn[:person_id].eq(self.id))

    query = ee.project(Arel.sql("#{ee.name}.event_log_id as event_log_id"), Arel.sql("SUM(trusted_relationship_value) as total_relationship_value"))
    query = query.join(Arel.sql("INNER JOIN (#{pn_network.to_sql}) AS network ON #{ee.name}.entity_id = network.trusted_person_id AND #{ee.name}.entity_type = 'Person'"))
    query = query.group(ee[:event_log_id]).order("#{ee.name}.created_at DESC").take(25)
    event_log_ids = EventEntity.find_by_sql(query.to_sql)
  end

  ###########
  # Trust related methods
  ###########
  
  def request_trusted_relationship(person_requesting)
    self.received_people_network_requests.create(:person => person_requesting)
  end
  
  def requested_trusted_relationship?(person_requesting)
    self.received_people_network_requests.where(:person_id => person_requesting).count > 0
  end

  def requested_trusted_relationship(person_requesting)
    self.received_people_network_requests.where(:person_id => person_requesting).first
  end
end
