When(/^the user is on the home page$/) do
  visit ('/')
end

Then(/^they should see a list of available tags$/) do
  page.should have_content("Tags")
  page.should have_content("education")
  page.should have_content("search")
end

