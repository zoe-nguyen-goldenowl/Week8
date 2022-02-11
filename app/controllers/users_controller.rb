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
            user.save
            
            redirect_to user_path(@user)
            UserMailer.welcome_email(@user).deliver_now
            
            # format.html { redirect_to(@user, notice: 'User was successfully created.') }
            # format.json { render json: @user, status: :created, location: @user }
        else
            render :index 
        end
    end
    
    def sig_in
    end

    def login
        user = User.find_by(name: params[:name])
        
        if user.authenticate(params[:password]) && user.is_verify
            redirect_to successful_path
        else

            redirect_to sig_in_path
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
        user = User.find(params[:user])
        debugger
        if user && user.token == params[:token]

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
