Given /^the logged person has accepted terms but not transparency nor principles$/ do
  logged_person = Person.first
  logged_person.update_attributes(:accepted_tc => true,
                                  :accepted_tr => false,
                                  :accepted_pp => false,
                                  :authorised_account   => true,
                                  :has_reviewed_profile => true)
end

Given /^the logged person has accepted transparency and principles but not terms$/ do
  logged_person = Person.first
  logged_person.update_attributes(:accepted_tc => false,
                                  :accepted_tr => true,
                                  :accepted_pp => true,
                                  :authorised_account   => true,
                                  :has_reviewed_profile => true)
end

Given /^the logged person has accepted terms and principles but not transparency$/ do
  logged_person = Person.first
  logged_person.update_attributes(:accepted_tc => true,
                                  :accepted_tr => false,
                                  :accepted_pp => true,
                                  :authorised_account   => true,
                                  :has_reviewed_profile => true)
end


Given /^the logged person has accepted terms and transparency but not principles$/ do
  logged_person = Person.first
  logged_person.update_attributes(:accepted_tc => true,
                                  :accepted_tr => true,
                                  :accepted_pp => false,
                                  :authorised_account   => true,
                                  :has_reviewed_profile => true)
end

Given /^the logged person has accepted legal notice but not principles$/ do
  logged_person = Person.first
  logged_person.update_attributes(:accepted_tc => true,
                                  :accepted_tr => true,
                                  :accepted_pp => false,
                                  :authorised_account   => true,
                                  :has_reviewed_profile => true)
end

Given /^the logged person has accepted all terms and conditions$/ do
  logged_person = Person.first
  logged_person.update_attributes(:accepted_tc => true,
                                  :accepted_tr => true,
                                  :accepted_pp => true,
                                  :authorised_account   => true,
                                  :has_reviewed_profile => true)
end


Then /^I should not see the header/ do
  page.should have_css('div#header', :visible => false)
end
