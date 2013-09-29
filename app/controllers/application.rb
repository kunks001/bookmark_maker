class Server < Sinatra::Base
  get '/' do
  	@links = Link.all
  	@tags = Tag.all
    haml :index
  end
end