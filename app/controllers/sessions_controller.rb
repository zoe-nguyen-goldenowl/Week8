class SessionsController < ApplicationController
    before_action :current_user

    def login
        @user = User.find_by(name: params[:name])
        if params[:name].blank? || params[:password].blank?
            flash[:login] = "User name and password not null!!"
            redirect_to sign_in_form_path
        elsif  @user.nil?
            flash[:login] = "User not exit!!"
            redirect_to sign_in_form_path
        elsif !@user.is_verify
            flash[:login] = "Check your mail!!"
            redirect_to sign_in_form_path

        elsif @user && @user.authenticate(params[:password])
            if params[:remember_me]
                cookies.permanent[:remember_token]= @user.remember_token
            else
                cookies[:remember_token]= @user.remember_token
            end
            redirect_to successful_path(@user)
        else
            flash[:login] = "mail or password fail!!"
            redirect_to sign_in_form_path
        end
        
    end 

end