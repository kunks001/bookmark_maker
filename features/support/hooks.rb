Before('@sign_up') do
  User.create(:email => 'test@test.com',
  			  :username => 'tester',
              :password => 'test_password',
              :password_confirmation => 'test_password')
end