class Link
  include DataMapper::Resource

  has n, :tags, 	:through => Resource
  has 1, :user, 	:through => Resource  
  has n, :users, 	:through => :favourite

  property :id, Serial
  property :title, String
  property :url, String
  property :description, String

  validates_presence_of :title, :message => "Please enter a title for your link"
  validates_presence_of :url, :message => "Please enter a url for your link"
end