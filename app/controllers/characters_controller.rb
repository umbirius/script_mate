require 'byebug'

class CharactersController < ApplicationController
    get '/projects/:id/characters/new' do
        @user = current_user
        @project = current_project
        erb :'characters/new'
    end 

    post '/projects/:id/characters' do
        @user = current_user
        @character = Character.new(character_params)
        if @character.save 
            redirect "/projects/#{current_project.id}/characters"
        else
        @errors = [params.to_s]
        erb :failure
        end
    end

    get '/projects/:id/characters' do
        @project = current_project
        @user = current_user
        @characters = current_project.characters
        erb :'characters/index'
    end 

    get '/projects/:id/characters/:char_id' do
        @user = current_user 
        @character = Character.find_by(id: params[:char_id])
        @project = current_project
        if @character 
            erb :'characters/id_page'
        else 
            @errors = ["no page here"]
            erb :failure
        end
    end 

    get '/projects/:id/characters/:char_id/edit' do
        @user = current_user
        @character = Character.find_by(id: params[:char_id])
        @project = current_project 
        if @character
            erb :'characters/edit'
            # redirect "/projects/#{@project.id}/characters/#{@character.id}"
        else
            @errors = ["no page here"]
            erb :failure
        end 
    end 

    patch '/projects/:id/characters/:char_id' do
        @user = current_user
        @character = Character.find_by(id: params[:char_id])
        @project = current_project
        if @character.update(character_params)
            redirect "/projects/#{@project.id}/characters"
        else
            @errors = ["no page here"]
            erb :failure
        end
    end

    delete '/projects/:id/characters/:char_id/delete' do
        @user = current_user
        @character = Character.find_by(id: params[:char_id])
        @project = current_project 
        if @character
            @character.delete
            redirect "/projects/#{@project.id}"
        else
            @errors = ["no page here"]
            erb :failure
        end
    end

    private

    def character_params
        { name: params[:name], age: params[:age], bio: params[:bio], project_id: current_project.id}
    end 
end