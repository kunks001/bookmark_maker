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

    user.password = params[:new_password]
    user.password_confirmation = params[:new_password_confirmation]

    user.save
    redirect to ('sessions/new')
  end

  post '/users' do
    @user = User.new(:email => params[:email], 
                :password   => params[:password],
                :password_confirmation => params[:password_confirmation])  
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      haml :"users/new"
    end
  end

  post '/sessions/users/reset_password' do
    email = params[:email_recovery_token]

    user = User.first(:email => email)
    user.recovery_token
    if user.save
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

  def send_message(token, email)
    RestClient.post "https://api:key-49tsww9jeu-mrc7f2pzyrauh7lfj5tx9"\
    "@api.mailgun.net/v2/bookmarkmaker.mailgun.org/messages",
    :from => "NoReply <noreply@bookmarkmaker.mailgun.org>",
    :to => "#{email}",
    :subject => "reset your password",
    :text => "reset your password by following this link: bookmark_maker.herokuapp.com/users/reset_password?token=#{token}"
  end

end