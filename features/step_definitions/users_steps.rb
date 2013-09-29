module EmailHelpers
  def current_email_address
    last_email_address || "example@example.com"
  end
end

Given(/^the user is visiting the signup page$/) do
  visit ('/users/new')
end

When(/^the user enters their information and clicks submit$/) do
  fill_in "email", :with => "test@test.com"
  fill_in "username", :with => "tester"
  fill_in "password", :with => "test_password"
  fill_in "password_confirmation", :with => "test_password"
  click_button("Sign up")
end

Then(/^they should be redirected to the index page$/) do
  page.should have_content("Current links:")
end

Then(/^there should be a welcome message$/) do
  page.should have_content("Welcome to the bookmark maker, tester")
end

When(/^the user enters an incorrect email and clicks submit$/) do
  fill_in "email", :with => "test.com"
  fill_in "username", :with => "tester"
  fill_in "password", :with => "test_password"
  fill_in "password_confirmation", :with => "test_password"
  click_button("Sign up")
  end

When(/^the user enters an incorrect password and clicks submit$/) do
fill_in "email", :with => "test@test.com"
  fill_in "username", :with => "tester"
  fill_in "password", :with => "test_password"
  fill_in "password_confirmation", :with => "tes_password"
  click_button("Sign up")
end

# When(/^the user enters a password of incorrect length and clicks submit$/) do
#   fill_in "email", :with => "test@test.com"
#   fill_in "username", :with => "tester"
#   fill_in "password", :with => "test"
#   fill_in "password_confirmation", :with => "test"
#   click_button("Sign up")
# end

Then(/^there should be an error message that the password is an incorrect length$/) do
  page.should have_content("Password must be between 6 and 20 characters long")
end

Then(/^there should be an error message that the password is incorrect$/) do
  page.should have_content("Password does not match the confirmation")
end

Then(/^they should be redirected to the signup page$/) do
  page.should have_content("Please sign up")
end

Then(/^there should be an error message$/) do
  page.should have_content("The email you have entered is not valid. Please try again")
end


Given(/^the user is signed in$/) do
  (visit '/sessions/new')
  within("#sign-in") do
    fill_in "email", :with => "test@test.com"
    fill_in "password", :with => "test_password"
    click_button("Sign in")
  end
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
  within('#sign-in') do
    fill_in "email", :with => "test@test.com"
    fill_in "password", :with => "test_password"
    click_button("Sign in")
  end
end

Given(/^the user has forgotten their password$/) do
  User.create(:email => 'example@example.com',
                :password => 'example',
                :password_confirmation => 'example')
  visit('/sessions/new')
  page.should have_content("Forgotten your password?")
end

When(/^the user fills in the forgotten password form$/) do
  within('#recover-password') do
    fill_in "email", :with => "example@example.com"
    click_button("Submit")
  end
end

When(/^the user visits the signup page and tries to sign up$/) do
  visit('/users/new')
  fill_in "email", :with => "test2@test.com"
  fill_in "username", :with => "tester2"
  fill_in "password", :with => "test_password2"
  fill_in "password_confirmation", :with => "test_password2"
  click_button("Sign up")
end

When(/^the user visits the signin page and tries to sign in$/) do
  visit('/sessions/new')
  within('#sign-in') do
    fill_in "email", :with => "test@test.com"
    fill_in "password", :with => "test_password"
    click_button("Sign in")
  end
end



Then(/^there should be an error message that they're already signed in$/) do
  page.should have_content("You're already signed in!")
end


# Then /^(?:I|they|he|she|"([^"]*?)") should receive (an|no|\d+) emails? with subject "([^"]*?)"$/ do |address, amount, subject|
#   unread_emails_for(address).select { |m| m.subject =~ Regexp.new(Regexp.escape(subject)) }.size.should == parse_email_count(amount)
# end
