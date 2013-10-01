class Server < Sinatra::Base
  
  get '/links/new' do
    haml :"links/new"
  end

  post '/links/new' do
      url = params["url"]
      title = params["title"]
      description = params["description"]
      user = current_user
      tags = params["tags"].split(" ").map do |tag|
      Tag.first_or_create(:text => tag)
    end
    link = Link.new(  :url => url, 
                      :title => title, 
                      :tags => tags, 
                      :description => description,
                      :user => user
                    )
    if link.save
      redirect to('/')
    else
      flash.now[:errors] = link.errors.full_messages
      haml :index
    end
  end

  post '/links/favourite' do
    link = params["link_id"]
    user = current_user
    link = Link.get(link)
    Favourite.create(  :user => user,
                       :link => link
                    )
    redirect to('/')
  end
end