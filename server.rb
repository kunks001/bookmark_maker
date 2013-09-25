require 'sinatra'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'rack-flash'

class Server < Sinatra::Base

  env = ENV["RACK_ENV"] || "development"

  DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

  require './lib/link'
  require './lib/tag'
  require './lib/user'

  DataMapper.finalize
  DataMapper.auto_upgrade!

  enable :sessions
  set :session_secret, 'super secret'
  use Rack::Flash

  def current_user    
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end

  get '/' do
  	@links = Link.all
  	erb :index
  end

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.new(:email => params[:email], 
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])  
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash[:notice] = "Sorry, your passwords don't match"
      erb :"users/new"
    end
  end

  get '/tags/:text' do
  	tag = Tag.first(:text => params[:text])
  	@links = tag ? tag.links : []
  	erb :index
  end

  post '/links' do
    url = params["url"]
    title = params["title"]
    tags = params["tags"].split(" ").map do |tag|
    Tag.first_or_create(:text => tag)
  	end
  	Link.create(:url => url, :title => title, :tags => tags)
    redirect to('/')
  end

end