require 'bcrypt'
require 'dm-timestamps'
require 'active_support'

class User

	include DataMapper::Resource

	property :id, Serial
  property :email, String, :unique => true, :message => "This email is already taken"
	property :password_digest, Text
  property :password_token, Text
  property :password_token_timestamp, Time

  attr_accessor :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
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