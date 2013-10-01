class Favourite
	
	include DataMapper::Resource

  belongs_to :link,   :key => true
  belongs_to :user, 	:key => true
end