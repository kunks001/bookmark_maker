Before('@sign_up') do
  User.create(:email => 'test@test.com',
              :username => 'tester',
              :password => 'test_password',
              :password_confirmation => 'test_password')
end

Before('@sign_in') do
  visit('/sessions/new')
  within('#sign-in') do
    fill_in "email", :with => "test@test.com"
    fill_in "password", :with => "test_password"
    click_button("Sign in")
  end
end