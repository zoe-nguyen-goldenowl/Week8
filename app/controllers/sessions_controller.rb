require 'digest'
class SessionsController < ApplicationController
    before_action :current_user

    def login
        @user = User.find_by(name: params[:name])
        if params[:remember_me]
            cookies.permanent[:remember_token]= @user.remember_token
        else
            cookies[:remember_token]= @user.remember_token
        end
        
        if !@user.is_verify 
            flash[:notice] = "Check your mail!!"
        else
        
            if @user && @user.authenticate(params[:password]) && @user.is_verify
            
                redirect_to successful_path(@user)
            else
                flash[:notice] = "user or password incorrect!!"
            end
        end

    end 

    def logout
        cookies.delete(:remember_token)
    end

end