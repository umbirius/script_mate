class SessionsController < ApplicationController

    get "/:user/profile" do 
        @user = current_user
         erb :'user/profile'
    end 
end 