require 'pry'

class SessionsController < ApplicationController

    get '/signup' do
        erb :'sessions/signup'
    end
    
    post '/signup' do
        user = User.new(user_params)
        if user.save
            flash[:success] = "Sign up successful!"
            redirect '/login'
        else
            flash[:error] = user.errors.messages.map {|key, value| "#{key}: #{value.first}"}
            redirect '/signup'
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

    get '/profile' do
        redirect_if_not_logged_in
        @user = current_user
        erb :'sessions/profile'
    end 

    get '/profile/edit' do
        redirect_if_not_logged_in
        @user = current_user
        erb :'sessions/edit_bio'
    end 

    patch '/profile' do
        redirect_if_not_logged_in
        @user = current_user
        if @user.update(bio: params[:bio])
            flash[:success] = "Profile has been updated"
            redirect '/profile'
        end
    end
end 