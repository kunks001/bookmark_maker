class Server < Sinatra::Base
  get '/sessions/new' do
    haml :"sessions/new"
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash.now[:errors] = ["The email or password are incorrect"]
      haml :"sessions/new"
    end
  end

  delete '/sessions' do
    flash[:notice] = "Good bye!"
    session[:user_id] = nil
    redirect to('/')
  end
end