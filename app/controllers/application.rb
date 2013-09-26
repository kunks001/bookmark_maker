class Server < Sinatra::Base
  get '/' do
  	@links = Link.all
    haml :index
  end
end