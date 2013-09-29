class Link
  include DataMapper::Resource

  has n, :tags, :through => Resource

  property :id, Serial
  property :title, String
  property :url, String
  property :description, String

  validates_presence_of :title, :message => "Please enter a title for your link"
  validates_presence_of :url, :message => "Please enter a url for your link"
end