
class SettingsController < ApplicationController

    get '/projects/:id/settings/new' do 
        @user = current_user
        @project = current_project
        erb :'settings/new'
    end

    post '/projects/:id/settings' do
        @user = current_user
        @setting = Setting.new(setting_params)
        if @setting.save 
            redirect "/projects/#{current_project.id}/settings"
        else
        @errors = [params.to_s]
        erb :failure
        end
    end

    get '/projects/:id/settings' do
        @project = current_project
        @user = current_user
        @settings = current_project.settings
        erb :'settings/index'
    end 

    get '/projects/:id/settings/:sett_id' do 
        @user = current_user
        @setting = Setting.find_by(id: params[:sett_id])
        @project = current_project
        if @setting 
            erb :'settings/id_page'
        else 
            @errors = ["no page here"]
            erb :failure
        end
    end 

    get '/projects/:id/settings/:sett_id/edit' do 
        @user = current_user
        @setting = Setting.find_by(id: params[:sett_id])
        @project = current_project 
        if @setting
            erb :'settings/edit'
        else
            @errors = ["no page here"]
            erb :failure
        end 
    end 

    patch '/projects/:id/settings/:sett_id' do 
        @user = current_user
        @setting = Setting.find_by(id: params[:sett_id])
        @project = current_project
        if @setting.update(setting_params)
            redirect "/projects/#{@project.id}/settings"
        else
            @errors = ["no page here"]
            erb :failure
        end
    end


    delete '/projects/:id/settings/:sett_id/delete' do 
        @user = current_user
        @setting = Setting.find_by(id: params[:sett_id])
        @project = current_project 
        if @setting
            @setting.delete
            redirect "/projects/#{@project.id}"
        else
            @errors = ["no page here"]
            erb :failure
        end
    end


    private

    def setting_params
        { name: params[:name], description: params[:description], project_id: current_project.id}
    end 

end