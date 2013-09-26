module EmailHelpers
  def current_email_address
    last_email_address || "example@example.com"
  end
end

# World(EmailHelpers)

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

Given(/^the user is signed in$/) do
  (visit '/sessions/new')
  fill_in "email", :with => "fake@fake.com"
  fill_in "password", :with => "foobar"
  click_button("Sign in")
end

When(/^the user clicks sign out$/) do
  click_button("Sign out")
end

Then(/^there should be a goodbye message$/) do
  page.should have_content("Good bye!")
end

Given(/^the user is signed out$/) do
  visit('/')
  page.should_not have_content("Welcome to the bookmark maker")
end

When(/^the user signs in$/) do
  visit('/sessions/new')
  fill_in "email", :with => "fake@fake.com"
  fill_in "password", :with => "foobar"
  click_button("Sign in")
end

Given(/^the user has forgotten their password$/) do
  User.create(:email => 'example@example.com',
                :password => 'example',
                :password_confirmation => 'example')
  visit('/sessions/new')
  page.should have_content("Forgotten your password?")
end

When(/^the user fills in the forgotten password form$/) do
  fill_in "email_recovery_token", :with => "example@example.com"
  click_button("Submit")
end

Then(/^they should receive an email containing a temporary password$/) do
  unread_emails_for("example@example.com").size.should == 1
end
