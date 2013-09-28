Before('@sign_up') do
  User.create(:email => 'test@test.com',
  			      :username => 'tester',
              :password => 'test',
              :password_confirmation => 'test')
end