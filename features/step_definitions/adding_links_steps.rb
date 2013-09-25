Given(/^the user is visiting the site$/) do
  visit('/')
end

When(/^the user enters a new link and clicks Add link$/) do
  fill_in "url", :with => "http://google.co.uk"
  fill_in "title", :with => "Google"
  fill_in "tags", :with => "Search"
  find(:button, 'Add link').click
end

Then(/^the link should be displayed$/) do
  page.should have_content("Google")
end

Then(/^should go to the correct website$/) do
  page.should have_xpath("//a[@href='#{'http://google.co.uk'}']")
end