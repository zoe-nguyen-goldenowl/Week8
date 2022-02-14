require 'digest'
class UsersController < ApplicationController
    def index
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
            
            redirect_to user_path(@user)
            UserMailer.welcome_email(@user).deliver_now
            
            # format.html { redirect_to(@user, notice: 'User was successfully created.') }
            # format.json { render json: @user, status: :created, location: @user }
        else
            render :index 
        end
    end

    def login
        user = User.find_by(name: params[:name])
    
        if user && user.authenticate(params[:password]) && user.is_verify
            redirect_to successful_path
            
        else
            flash.now[:alert] = "Email or password is invalid"
        end
        
    end 

    def destroy
        set_user.destroy
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
        end
        
    end

    def forgot_password 
        if params[:name] != nil
            @user = params[:name]
            UserMailer.check_password(@user).deliver_now
        end
    end

    def change_pass
        if  params[:password] != nil && params[:password_confirm]
            
            if params[:password] == params[:password_confirm]
              user =User.find_by(name: params[:name])
              user.password = params[:password]
              user.save
            else

            end

        end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :password)
    end
end
