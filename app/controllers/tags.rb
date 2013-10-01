class Server < Sinatra::Base
  get '/tags/:text' do
    tag = Tag.first(:text => params[:text])
    @links = tag ? tag.links : []
    haml :index
  end
end
