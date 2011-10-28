ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendererd within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  section "Settings" do
    ul do
      render 'settings' # => this will render /app/views/admin/dashboard/_settings.html.erb
    end
  end
  
  section "New 10 Users" do
       ul do
         'Feature coming soon'
       end
  end
  
  section "Top 10 by activity" do
       ul do
         'Feature coming soon'
       end
  end

  #The only way to make this work on clean install
  if ActiveRecord::Base.connection.table_exists? 'settings' 
		if Settings.invitations.to_s == 'true'
		  section "Send an invitation via email" do
		     ul do
		       render 'invite'
		     end
		  end
		end
  end
  

end
