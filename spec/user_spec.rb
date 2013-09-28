require 'spec_helper'

feature "User signs up" do

  scenario "when registering" do
    lambda { sign_up }.should change(User, :count).by(1)
    expect(page).to have_content("Welcome to the bookmark maker, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")
  end

  scenario "with a password that doesn't match" do
    lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(User, :count).by(0)
    expect(current_path).to eq('/users')   
    # expect(page).to have_content("Sorry, your passwords don't match")
  end

  scenario "with an email that is already registered" do    
    lambda { sign_up }.should change(User, :count).by(1)
    lambda { sign_up }.should change(User, :count).by(0)
    expect(page).to have_content("This email is already taken")
  end

end

feature "User signs in" do
  before(:each) do
    User.create(:email => 'test@test.com',
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'test')
    expect(page).to have_content("Welcome to the bookmark maker, test@test.com")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end

feature "User signs out" do
  before(:each) do
    User.create(:email => 'test@test.com',
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'test')
    click_button "Sign out"
    expect(page).to have_content("Good bye!")
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end

feature "User tries to reset password" do
  before(:each) do
    User.create(:email => 'test@test.com',
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario 'with correct information' do
    visit '/sessions/new'
    within("#recover-password") do
      fill_in "email", :with => "test@test.com"    
      click_button "Submit"
    end
    user = User.first(:email => "test@test.com")

    expect(user.password_token.length).to be == 64
    expect(user.password_token_timestamp).to be_an_instance_of Time
  end
end

def sign_in(email, password)
  visit '/sessions/new'
  within('#sign-in') do
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end
end
  
def sign_up(email = "alice@example.com",
            password = "oranges!",
            password_confirmation = "oranges!")
  visit '/users/new'
  fill_in :email, :with => email
  fill_in :password, :with => password
  fill_in :password_confirmation, :with => password_confirmation
  click_button "Sign up"
end