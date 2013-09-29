Given(/^the user has signed in$/) do
  visit ('/sessions/new')
  within("#sign-in") do
	  fill_in "email",     :with => "test@test.com"
	  fill_in "password",  :with => "test"
	  click_button("Sign in")
  end
end

When(/^the user enters a new link and clicks Add link$/) do
  visit ('/links/new')
  fill_in "url",         :with => "http://google.co.uk"
  fill_in "title",       :with => "Google"
  fill_in "tags",        :with => "Search"
  fill_in "description", :with => "search engine"
  find(:button, 'Add link').click
end

Then(/^the link should be displayed$/) do
  page.should have_content("Google")
end

Then(/^should go to the correct website$/) do
  page.should have_xpath("//a[@href='#{'http://google.co.uk'}']")
end

When(/^the user enters a new link without a title and clicks Add link$/) do
  visit ('/links/new')
  fill_in "url",         :with => "http://google.co.uk"
  fill_in "tags",        :with => "Search"
  fill_in "description", :with => "search engine"
  find(:button, 'Add link').click
end

Then(/^there should be an error message to include a title$/) do
  page.should have_content("Please enter a title")
end