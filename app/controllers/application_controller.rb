require 'byebug'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "burger-king"
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
      @errors = ["User already signed up"]
      erb :failure
    elsif User.find_by(email: params[:email])
      @errors = ["There is a username associated with <%= params[:email] %>"]
      erb :failure
    else
      @errors = ["Not yet implemented"]
      erb :failure
    end
  end

  get '/login' do
    erb :login
  end

  get '/logout' do
    session.clear
    redirect '/'
  end 


  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/projects"
    else
        @errors = ["Invalid username or password"]
        erb :failure
    end
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