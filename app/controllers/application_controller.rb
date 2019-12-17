require 'byebug'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "burger-king"

    register Sinatra::Flash
  end 

  get '/' do
    @days = Day.all
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
    
  end 

  private

  def user_params
    { username: params[:username], password: params[:password] }
  end

end