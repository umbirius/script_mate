
class SettingsController < ApplicationController

    get '/projects/:id/settings/new' do 
        redirect_if_not_logged_in
        @user = current_user
        @project = current_project
        erb :'settings/new'
    end

    post '/projects/:id/settings' do
        redirect_if_not_logged_in
        @user = current_user
        @setting = Setting.new(setting_params)
        if @setting.save
            flash[:success] = "Setting has been created."
            redirect "/projects/#{current_project.id}/settings"
        end
    end

    get '/projects/:id/settings' do 
        redirect_if_not_logged_in
        redirect_if_not_user(Project, params[:id], '/projects')
        @project = current_project
        @user = current_user
        @settings = current_project.settings
        erb :'settings/index'
    end 

    get '/projects/:id/settings/:sett_id' do 
        redirect_if_not_logged_in
        redirect_if_project_content_not_user(Setting, params[:sett_id], "/projects/#{params[:id]}/settings")
        @user = current_user
        @setting = Setting.find_by(id: params[:sett_id])
        @project = current_project
        if @setting 
            erb :'settings/id_page'
        end
    end 

    get '/projects/:id/settings/:sett_id/edit' do 
        redirect_if_not_logged_in
        @user = current_user
        @setting = Setting.find_by(id: params[:sett_id])
        @project = current_project 
        if @setting
            erb :'settings/edit'
        end 
    end 

    patch '/projects/:id/settings/:sett_id' do 
        redirect_if_not_logged_in
        @user = current_user
        @setting = Setting.find_by(id: params[:sett_id])
        @project = current_project
        if @setting.update(setting_params)
            flash[:success] = "Setting update complete."
            redirect "/projects/#{@project.id}/settings"
        end
    end


    delete '/projects/:id/settings/:sett_id' do 
        @user = current_user
        @setting = Setting.find_by(id: params[:sett_id])
        @project = current_project 
        if @setting
            @setting.delete
            flash[:success] = "Setting has been deleted."
            redirect "/projects/#{@project.id}/settings"
        end
    end


    private

    def setting_params
        { name: params[:name], description: params[:description], project_id: current_project.id}
    end 

end