require 'byebug'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "burger-king"

    register Sinatra::Flash
  end 

  get '/' do
    @title = "ScriptMate"
    @days = Day.all
    if !!logged_in?
      @user = current_user
      erb :home
    else 
      erb :home 
    end 
  end

  get '/about' do
    if logged_in? 
      @user = current_user
    end 
    @title = "ScriptMate" 
    erb :about
  end 

  helpers do 
    def logged_in?
      !!session[:user_id]
    end 

    def redirect_if_not_logged_in
      unless logged_in?
        flash[:error] = "You must log in for that function."
        redirect to '/login'
      end 
    end 

    def current_user
      User.find(session[:user_id])
    end

    def current_project
      Project.find(session[:project_id])
    end

    def redirect_if_not_user(class_var, id, desired_path)
      if class_var.exists?(id)
        unless class_var.find(id).user == current_user
          flash[:error] = "Access Denied: Restricted pathway"
          redirect desired_path
        end
      else
        flash[:error] = "Access Denied: Restricted pathway"
        redirect desired_path
      end 
    end 
    
  end 

  private

  def user_params
    { username: params[:username], password: params[:password] , email: params[:email]}
  end

end