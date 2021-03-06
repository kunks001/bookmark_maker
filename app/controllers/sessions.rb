class Server < Sinatra::Base
  get '/sessions/new' do
    haml :"sessions/new"
  end

  post '/sessions' do
    if session[:user_id] != nil
      flash.now[:notice] = "You're already signed in!"
      haml :index
    else
      email, password = params[:email], params[:password]
      user = User.authenticate(email, password)
      if user
        session[:user_id] = user.id
        flash[:notice] = "Welcome to the bookmark manager, #{current_user.username}"
        redirect to('/')
      else
        flash.now[:errors] = ["The email or password are incorrect"]
        haml :"sessions/new"
      end
    end
  end

  delete '/sessions' do
    flash[:notice] = "Good bye!"
    session[:user_id] = nil
    redirect to('/')
  end
end