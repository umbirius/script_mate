require 'byebug'
class ProjectsController < ApplicationController
    
    get '/projects' do
        redirect_if_not_logged_in
        @user = current_user
        @projects = current_user.projects
        erb :'projects/index'
    end 
    
    get '/projects/new' do
        @user = current_user
        erb :'projects/new' 
    end 

    post '/projects' do
        redirect_if_not_logged_in
        @user = current_user
        project = Project.new(project_params)
        if project.save 
            redirect '/projects'
        else
        @errors = [params.to_s]
        erb :failure
        end
    end
    
    get '/projects/:id' do
        @user = current_user
        @project = Project.find_by(id: params[:id])
        session[:project_id] = @project.id
        @characters = current_project.characters
        @scenes = current_project.scenes
        @settings = current_project.settings
        erb :'projects/id_page'
    end

    get '/projects/:id/edit' do
        @user = current_user
        redirect_if_not_logged_in 
        @project = Project.find_by(id: params[:id])
        if @project 
            erb :'projects/edit'
        else 
            @errors = ["invalid quote id"]
            erb :failure
        end 
    end 

    patch '/projects/:id' do
        redirect_if_not_logged_in
        @user = current_user
        @project = Project.find_by(id: params[:id])
        if @project.update(project_params)
            redirect '/projects'
        else
            @errors = ["not implimented yet"]
            erb :failure
        end 
    end


    delete '/projects/:id/delete' do
        @user = current_user
        @project = Project.find_by(id: params[:id])
        if @project
            @project.delete
            redirect "/projects"
        else
            @errors = ["no page here"]
            erb :failure
        end
    end

    private

    def project_params
        { name: params[:name], bio: params[:bio], artform: params[:artform], genre: params[:genre], user: current_user}
    end 
end 