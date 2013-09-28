class Server < Sinatra::Base
  post '/links' do
      url = params["url"]
      title = params["title"]
      description = params["description"]
      tags = params["tags"].split(" ").map do |tag|
      Tag.first_or_create(:text => tag)
    end
    Link.create(:url => url, :title => title, :tags => tags, :description => description)
    redirect to('/')
  end
end