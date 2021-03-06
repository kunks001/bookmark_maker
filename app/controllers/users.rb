class Server < Sinatra::Base
  get '/users/new' do
    @user = User.new
    haml :"users/new"
  end

  get '/users/reset_password' do
    token = params[:token]
    haml :"users/reset"
  end

  post '/users/reset_password' do
    token = params[:token]
    user = User.first(:password_token => token)
    
    user.update( :password => params[:password],
                 :password_confirmation => params[:password_confirmation])

    if user.save
      redirect to ('sessions/new')
    else
      flash.now[:notice] = "Sorry, reset failed. Please try again"
    end
  end

  post '/users' do
    if current_user
      flash.now[:notice] = "You're already signed in!"
      haml :index
    else
      @user = User.new( :email                  => params[:email], 
                        :username               => params[:username],
                        :password               => params[:password],
                        :password_confirmation  => params[:password_confirmation])  
      if @user.save
        email = @user.email
        username = @user.username
        send_welcome(email, username)
        session[:user_id] = @user.id
        redirect to('/')
      else
        flash.now[:errors] = @user.errors.full_messages
        haml :"users/new"
      end
    end
  end

  post '/users/reset_token' do
    email = params[:email]

    user = User.first(:email => email)
    user.generate_password_token    
    if user.save && Time.now < user.password_token_timestamp
      token = user.password_token
      send_message(token, email)

    # Pony.mail(
    #   :to => email,
    #   :from => 'noreply@bookmarkmaker.com', 
    #   :subject => 'reset your password',
    #   :body => 'reset your password by following this link: bookmark_maker.herokuapp.com/users/#{token}'
    # )
  
      redirect to('sessions/new')
    else
      flash.now[:notice] = "Sorry, password_reset failed. please try again"
      redirect to('sessions/new')
    end
  end

  get "/users/profile" do
    @links = current_user.links
    @favourites = current_user.favourite_links
    haml :"users/profile"
  end

  get '/users/favourites' do
    haml :"users/favourites"
  end

  def send_message(token, email)
    RestClient.post "https://api:key-49tsww9jeu-mrc7f2pzyrauh7lfj5tx9"\
    "@api.mailgun.net/v2/bookmarkmaker.mailgun.org/messages",
    :from => "NoReply <noreply@bookmarkmaker.mailgun.org>",
    :to => "#{email}",
    :subject => "reset your password",
    :text => "reset your password by following this link: bookmark_maker.herokuapp.com/users/reset_password?token=#{token}"
  end

  def send_welcome(email, username)
    RestClient.post "https://api:key-49tsww9jeu-mrc7f2pzyrauh7lfj5tx9"\
    "@api.mailgun.net/v2/bookmarkmaker.mailgun.org/messages",
    :from => "NoReply <noreply@bookmarkmaker.mailgun.org>",
    :to => "#{email}",
    :subject => "welcome",
    :text => "Welcome to the bookmark manager, #{username}! Now you've signed up you'll be able to start adding links in no time."
  end
end