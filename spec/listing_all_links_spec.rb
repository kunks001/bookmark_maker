require 'spec_helper'

feature 'User browses the list of links' do

  before(:each) {
    sign_up('test@test.com', 'tester', 'test_password', 'test_password')
    sign_in('test@test.com', 'test_password')

    add_link("http://www.makersacademy.com", "Makers Academy", ['education'],
              "intensive 12 week course")
    add_link("http://www.google.com", "Google", ['search'], 'search engine')
    add_link("http://www.bing.com", "Bing", ['search'], 'search engine')
    add_link("http://www.code.org", "Code.org", ['education'], 'online code school')
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Makers Academy")
  end

  scenario "filtered by a tag" do
    visit '/tags/search'
    expect(page).not_to have_content("Makers Academy")
    expect(page).not_to have_content("Code.org")
    expect(page).to have_content("Google")
    expect(page).to have_content("Bing")
  end

  scenario "Links are associated with a user" do
    sign_up("test@test.com", "tester", "test_password", "test_password")
    sign_in("test@test.com", "test_password")
    add_link("google.co.uk", "google",["search"], "search engine")
    page.should have_content("Added by tester")
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
              username = "alice",
              password = "oranges!",
              password_confirmation = "oranges!")
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :username, :with => username
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
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
end