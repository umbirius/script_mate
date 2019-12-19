require 'pry'
class ScenesController < ApplicationController

    get '/projects/:id/scenes/new' do 
        redirect_if_not_logged_in
        @user = current_user
        @project = current_project
        erb :'scenes/new'
    end 
    

    post '/projects/:id/scenes' do
        redirect_if_not_logged_in
        @user = current_user
        @scene = Scene.new(scene_params)
        if @scene.save 
            flash[:success] = "Scene has been created."
            redirect "/projects/#{current_project.id}/scenes"
        end
    end

    get '/projects/:id/scenes/order/edit' do
        redirect_if_not_logged_in
        @project=current_project
        @user = current_user
        @scenes = current_project.scenes
        if @scenes 
            erb :'scenes/order_edit'
        end 
    end

    patch '/projects/:id/scenes/order' do
        redirect_if_not_logged_in
        @project = current_project
        @user = current_user
        @scenes = @project.scenes
        @scenes.each do |scene|
            scene.order = nil
            scene.save
        end
        i = 0
        @scenes.each do |scene|

            scene.order = params[:order][i]
            if scene.save
            else 
                scene.update(order: nil) 
            end
            i+=1
        end

        if @project.scenes.find_by(order: nil)
            flash[:error] = "All scenes must have a unique position in the sequence, re-enter order."
            redirect "/projects/#{@project.id}/scenes/order/edit"
        else 
            flash[:success] = "Scene order has been updated."
            redirect "/projects/#{@project.id}/scenes"
        end
    end

    get '/projects/:id/scenes' do
        redirect_if_not_logged_in
        @project = current_project
        @user = current_user
        @scenes = current_project.scenes
        erb :'scenes/index'
    end 

    get '/projects/:id/scenes/:scene_id' do 
        redirect_if_not_logged_in
        @user = current_user
        @scene = Scene.find_by(id: params[:scene_id])
        @project = current_project
        if @scene 
            erb :'scenes/id_page'
        end
    end 

    get '/projects/:id/scenes/:scene_id/edit' do 
        redirect_if_not_logged_in
        @user = current_user
        @scene = Scene.find_by(id: params[:scene_id])
        @project = current_project 
        if @scene
            erb :'scenes/edit'
        end 
    end 

    patch '/projects/:id/scenes/:scene_id' do
        redirect_if_not_logged_in
        @user = current_user
        @scene = Scene.find_by(id: params[:scene_id])
        @project = current_project
        if @scene.update(scene_params)
            flash[:success] = "Scene update complete."
            redirect "/projects/#{@project.id}/scenes"
        end
    end

    delete '/projects/:id/scenes/:scene_id' do
        redirect_if_not_logged_in
        @user = current_user
        @scene = Scene.find_by(id: params[:scene_id])
        @project = current_project 
        if @scene
            @scene.delete
            flash[:success] = "Scene has been deleted."
            redirect "/projects/#{@project.id}/scenes"
        end
    end
    private

    def scene_params
        { name: params[:name], description: params[:description], project_id: current_project.id}
    end

end