require 'digest'

class UsersController < ApplicationController
    before_action :set_user, only: [:destroy, :edit]
    
    before_action :change_pass, only: [:check_password_view]
    before_action :log_in_successful_view, only: [:change_pass]

    def index
        @user = User.is_verify
    end

    def sign_in
        if @current_user
            redirect_to successful_path(@current_user)
       else
            redirect_to sign_in_form_path
       end
    end

    def show
    end

    def new
    end

    def edit
    end
    
    def edit_user
        name= params[:name]
        pass= params[:password]
        user= User.find_by(id: params[:id])
        if user.update(name: name, password: pass)
            flash[:edit] = "Edit account successful!"
            redirect_to users_path
        else
            flash[:edit] = "Edit fail!"
            redirect_to users_path
        end
    end

    def create
        @user = User.new(user_params)
        token =  Digest::MD5.hexdigest(@user.name)
        
        if @user.save
            user = User.find_by(name: @user.name)
            user.update(token: token)
            UserMailer.welcome_email(@user).deliver_now
            flash[:save_successful] = "Create account successful! Check your mail"
            redirect_to users_path(user)
        else
            flash[:create_fails] = "#{@user.errors.full_messages}"
            redirect_to new_path
        end
    end

    def destroy
        if @user.destroy 
            cookies.delete(:remember_token)
            redirect_to users_path
        else
            flash[:sestroy] = "Delete user fail!!"
            redirect_to users_url
        end
    end

    def verify
        user= User.find_by(name: params[:name])
        
        if user.token == params[:token]
            user.update(is_verify: 'true')
            flash[:verify] = "verify successful!!"
            redirect_to users_url
        else
            user.update(is_verify: 'false')
            flash[:verify] = "verify fail!!"
            redirect_to users_url
        end
        
    end

    def forgot_password 
        if params[:name] != nil
            user= User.find_by(name: params[:name])
            random= rand(0..100).to_s
            user.update(token_change_pass: random)
            UserMailer.check_mail(user).deliver_now
        end
    end

    def check_password_view
        @user= User.find_by(name: params[:name])
        if @user.token_change_pass == params[:token_change_pass]
            render :new_password
        else
            respond_to do |format|
            
                format.json{render json.alert("Check your mail!!")}
            end
        end
    end

    def change_pass 
        if params[:name].length == 0 || params[:password_field].length == 0 || params[:password_confirm].length == 0
            flash[:notice] = "Password and email not nul!!"
            redirect_to new_password_path
        elsif params[:password_field] != params[:password_confirm]
            flash[:notice] = "Check password and password confirm!!"
            redirect_to new_password_path
        else
            user= User.find_by(name: params[:name])
            
            if !user.nil?
                user.update(password: params[:password_field])
                redirect_to sign_in_form_path
            else
                flash[:notice] = "User name not exist!!"
                redirect_to new_password_path    
            end
        end
        
    end

    def log_in_successful_view
        @user =  User.find_by(id: params[:id])
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :password)
    end
end
