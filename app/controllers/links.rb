class Server < Sinatra::Base
  post '/links' do
      url = params["url"]
      title = params["title"]
      description = params["description"]
      tags = params["tags"].split(" ").map do |tag|
      Tag.first_or_create(:text => tag)
    end
    link = Link.new(:url => url, :title => title, :tags => tags, :description => description, :user_id => session[:user_id])
    if link.save
      redirect to('/')
    else
      flash.now[:errors] = link.errors.full_messages
      haml :index
    end
  end
end