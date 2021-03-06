require 'spec_helper'

feature "Displaying the user" do

  before(:each) do
    User.create(:email => 'test@test.com',
                :username => 'tester',
                :password => 'test_password',
                :password_confirmation => 'test_password')
    sign_in('test@test.com', 'test_password')
  end

  def sign_in(email, password)
    visit '/sessions/new'
    within('#sign-in') do
      fill_in 'email', :with => email
      fill_in 'password', :with => password
      click_button 'Sign in'
    end
  end

  def add_link(url, title, tags = [], description = '')
    visit '/links/new'
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      fill_in 'tags', :with => tags.join(' ')
      fill_in 'description', :with => description
      click_button 'Add link'
    end      
  end

  scenario "when visiting the profile page" do
    add_link( "http://www.makersacademy.com/", 
              "Makers Academy", 
              ['education', 'ruby'],
              "Intensive 12 week coding course") 
    visit '/users/profile'
    expect(page).to have_content "tester"
    expect(page).to have_content "Makers Academy"
  end

end