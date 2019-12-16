class SessionsController < ApplicationController

    get '/signup' do
        erb :'sessions/signup'
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
        erb :'sessions/login'
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

    get "/:user/profile" do 
        @user = current_user
         erb :'user/profile'
    end 
end 