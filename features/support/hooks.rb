Before('@sign_up') do
  User.create(:email => 'test@test.com',
              :password => 'test',
              :password_confirmation => 'test')
end