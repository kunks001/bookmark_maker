Given(/^the user is visiting the signup page$/) do
  visit ('/users/new')
end

When(/^the user enters their information and clicks submit$/) do
  fill_in "email", :with => "fake@fake.com"
  fill_in "password", :with => "foobar"
  fill_in "password_confirmation", :with => "foobar"
  click_button("Sign up")
end

Then(/^they should be redirected to the index page$/) do
  page.should have_content("Current links:")
end

Then(/^there should be a welcome message$/) do
  page.should have_content("Welcome to the bookmark maker, fake@fake.com")
end