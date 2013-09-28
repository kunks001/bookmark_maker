require 'spec_helper'

feature "User adds a new link" do

  before(:each) do
  User.create(:email => 'test@test.com',
              :password => 'test',
              :password_confirmation => 'test')
  sign_in('test@test.com', 'test')
  end

  scenario "when browsing the homepage" do
    expect(Link.count).to eq(0)
    add_link("http://www.makersacademy.com/", "Makers Academy")
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.url).to eq("http://www.makersacademy.com/")
    expect(link.title).to eq("Makers Academy")
    link.destroy
    expect(Link.count).to eq(0)
  end

  scenario "with a few tags" do
    add_link( "http://www.makersacademy.com/", 
              "Makers Academy", 
              ['education', 'ruby'],
              "Intensive 12 week coding course")    
    link = Link.first
    expect(link.tags.map(&:text)).to include("education")
    expect(link.tags.map(&:text)).to include("ruby")
  end

  scenario "with a description" do
    add_link( "http://www.makersacademy.com/", 
              "Makers Academy", 
              ['education', 'ruby'],
              "Intensive 12 week coding course")    
    link = Link.first
    expect(link.description).to include("Intensive 12 week coding course")
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
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      fill_in 'tags', :with => tags.join(' ')
      fill_in 'description', :with => description
      click_button 'Add link'
    end      
  end

end