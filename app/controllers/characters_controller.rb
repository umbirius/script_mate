require 'byebug'

class CharactersController < ApplicationController
    get '/projects/:id/characters/new' do
        redirect_if_not_logged_in
        @user = current_user
        @project = current_project
        erb :'characters/new'
    end 

    post '/projects/:id/characters' do
        redirect_if_not_logged_in
        @user = current_user
        @character = Character.new(character_params)
        if @character.save
            flash[:success] = "Character has been created."
            redirect "/projects/#{current_project.id}/characters"
        end
    end

    get '/projects/:id/characters' do
        redirect_if_not_logged_in
        @project = current_project
        @user = current_user
        @characters = current_project.characters
        erb :'characters/index'
    end 

    get '/projects/:id/characters/:char_id' do
        redirect_if_not_logged_in
        @user = current_user 
        @character = Character.find_by(id: params[:char_id])
        @project = current_project
        if @character 
            erb :'characters/id_page'
        end
    end 

    get '/projects/:id/characters/:char_id/edit' do
        redirect_if_not_logged_in
        @user = current_user
        @character = Character.find_by(id: params[:char_id])
        @project = current_project 
        if @character
            erb :'characters/edit'
        end 
    end 

    patch '/projects/:id/characters/:char_id' do
        redirect_if_not_logged_in
        @user = current_user
        @character = Character.find_by(id: params[:char_id])
        @project = current_project
        if @character.update(character_params)
            flash[:success] = "Character update complete."
            redirect "/projects/#{@project.id}/characters"
        end
    end

    delete '/projects/:id/characters/:char_id/delete' do
        @user = current_user
        @character = Character.find_by(id: params[:char_id])
        @project = current_project 
        if @character
            @character.delete
            flash[:success] = "Character has been deleted."
            redirect "/projects/#{@project.id}"
        end
    end

    private

    def character_params
        { name: params[:name], age: params[:age], bio: params[:bio], project_id: current_project.id}
    end 
end