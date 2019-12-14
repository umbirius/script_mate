
class ScenesController < ApplicationController

    get '/projects/:id/scenes/new' do 
        @user = current_user
        @project = current_project
        erb :'scenes/new'
    end 
    

    post '/projects/:id/scenes' do
        @user = current_user
        @scene = Scene.new(scene_params)
        if @scene.save 
            redirect "/projects/#{current_project.id}/scenes"
        else
        @errors = [params.to_s]
        erb :failure
        end
    end

    get '/projects/:id/scenes' do
        @project = current_project
        @user = current_user
        @scenes = current_project.scenes
        erb :'scenes/index'
    end 

    get '/projects/:id/scenes/:scene_id' do 
        @user = current_user
        @scene = Scene.find_by(id: params[:scene_id])
        @project = current_project
        if @scene 
            erb :'scenes/id_page'
        else 
            @errors = ["no page here"]
            erb :failure
        end
    end 

    get '/projects/:id/scenes/:scene_id/edit' do 
        @user = current_user
        @scene = Scene.find_by(id: params[:scene_id])
        @project = current_project 
        if @scene
            erb :'scenes/edit'
        else
            @errors = ["no page here"]
            erb :failure
        end 
    end 

    patch '/projects/:id/scenes/:scene_id' do 
        @user = current_user
        @scene = Scene.find_by(id: params[:scene_id])
        @project = current_project
        if @scene.update(scene_params)
            redirect "/projects/#{@project.id}/scenes"
        else
            @errors = ["no page here"]
            erb :failure
        end
    end

    delete '/projects/:id/scenes/:scene_id/delete' do 
        @user = current_user
        @scene = Scene.find_by(id: params[:scene_id])
        @project = current_project 
        if @scene
            @scene.delete
            redirect "/projects/#{@project.id}"
        else
            @errors = ["no page here"]
            erb :failure
        end
    end
    private

    def scene_params
        { name: params[:name], description: params[:description], project_id: current_project.id}
    end

end