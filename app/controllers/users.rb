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

  post "/users/reset_password" do
    email = params[:email]
    user = User.first(:email => email)
    user.recovery_token
    token = user.password_token
    Pony.mail(:to => email, :from => 'noreply@bookmarkmaker.com', :subject => 'reset your password by following this link: bookmark_maker.herokuapp.com/users/#{token}')
  end

  get "/users/reset_password/:token" do
    user = User.first(:password_token => token)
  end

  # post '/users/password_reset' do
  # end
end