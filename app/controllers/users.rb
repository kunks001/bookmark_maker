class Server < Sinatra::Base
  get '/users/new' do
    @user = User.new
    haml :"users/new"
  end

  post '/users' do
    @user = User.new(:email => params[:email], 
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])  
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      haml :"users/new"
    end
  end

  # get '/users/password_reset/reset' do
  #   haml :"users/password_reset/reset"
  # end

  get "/users/reset_password/:token"
    email = params[:email]

    Pony.mail(:to => email, :from => 'noreply@bookmarkmaker.com', :subject => 'Hello')
  end

  # post '/users/password_reset' do
  # end
end