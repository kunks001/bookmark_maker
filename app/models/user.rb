require 'bcrypt'
require 'dm-timestamps'
require 'active_support'

class User

	include DataMapper::Resource

  has n, :links, :through => Resource

  property :id, Serial

	property :id, Serial
  property :email, String,  :required => true,
                            :unique => true, 
                            :format => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
                            :messages => {
                              :is_unique => "The email you have entered is already taken. Please try again",
                              :format    => "The email you have entered is not valid. Please try again"
                            }
  property :username, String, :required => true,
                              :unique => true, 
                              :message => "This username is already taken"
	property :password_digest, Text,  :required => true, 
                                    :message => "Please enter your password"
  property :password_token, Text
  property :password_token_timestamp, Time

  attr_accessor :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  # validates_length_of :password,  :min => 6, :max => 20
  # validates_length_of :password_confirmation, :min => 6, :max => 20
  validates_uniqueness_of :email

	def password=(password)
    @password=password
  	self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(:email => email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def generate_password_token  
    self.password_token_timestamp = Time.now + 60*60
    self.password_token = Array.new(64) {(65 + rand(58)).chr}.join
  end
end