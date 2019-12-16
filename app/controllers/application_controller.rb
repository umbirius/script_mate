require 'byebug'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "burger-king"

    register Sinatra::Flash
  end 

  get '/' do
    if !!logged_in?
      @user = current_user
      erb :home
    else 
      erb :home 
    end 
  end

  get '/failure' do 
    @errors = ["corn", "lemon", "bacon"]
    erb :failure
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.new(user_params)
    if User.find_by(username: params[:username])
      flash[:error] = "The username, #{params[:username]}, is already taken"
      redirect '/signup'
    elsif User.find_by(email: params[:email])
      flash[:error] = "There is a username associated with #{params[:email]}"
      redirect '/signup'
    else 
      flash[:success] = "Sign up successful!"
      redirect '/login'
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Login successful. Welcome, #{@user.username}!"
      redirect '/'
      redirect "/projects"
    else
      flash[:error] = "Invalid username or password"
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    flash[:success] = "Logout successful."
    redirect '/'
  end 


  helpers do 
    def logged_in?
      !!session[:user_id]
    end 

    def redirect_if_not_logged_in
      unless logged_in?
        redirect to '/login'
      end 
    end 

    def current_user
      User.find(session[:user_id])
    end

    def current_project
      Project.find(session[:project_id])
    end
    
  end 


  private

  def user_params
    { username: params[:username], password: params[:password] }
  end

end