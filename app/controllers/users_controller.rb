require 'digest'

class UsersController < ApplicationController
    before_action :current_user

    before_action :successful, only: [:change_pass]
    def index
      
    end

    def sign_in
        if @current_user
            redirect_to successful_path(@current_user)
       else
            redirect_to users_url
       end
    end

    def show
        @user = User.all
    end

    def create
        @user = User.new(user_params)
        token =  Digest::MD5.hexdigest(@user.name)
        if @user.save
            user = User.find_by(name: @user.name)
            user.update(token: token)
            UserMailer.welcome_email(@user).deliver_now
            redirect_to user_path(@user)
            
            # format.html { redirect_to(@user, notice: 'User was successfully created.') }
            # format.json { render json: @user, status: :created, location: @user }
        else
            render :index 
        end
    end

    def destroy
        set_user.destroy
        session[:current_user_id] = nil
        respond_to do |format|
            format.html { redirect_to user_path, notice: "User was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    def verify
        user= User.find_by(name: params[:name])
        
        if user.token == params[:token]
            user.update(is_verify: 'true')
            user.save
            redirect_to users_url
        end
        
    end

    def forgot_password 
        debugger
        if params[:name] != nil
            @user =User.find_by(name: params[:name])
            @user.token_change_pass= rand(0..100).to_s
            @user.save
            UserMailer.check_password(@user).deliver_now
        end
    end

    def new_password
        @user= User.find_by(name: params[:name])
        if @user.token_change_pass == params[:token_change_pass]
            render :new_password
            
        end
    end

    def change_pass 
        if params[:password] == nil || params[:password_confirm] == nil
            flash[:notice]="Password nil!!"
        else
            user= User.find_by(name: params[:name])
            if params[:password] == params[:password_confirm]
                user.password = params[:password]
                user.save     
                render  :index
            end
        end
    end

    def successful
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
