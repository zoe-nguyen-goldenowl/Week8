require 'digest'
class UsersController < ApplicationController


    def index
    end

    def show
        @user = User.all
    end

    def create
        @user = User.new(user_params)
            if @user.save
                redirect_to user_path(@user)
                # UserMailer.with(user: @user).welcome_email.deliver_later
                # UserMailer.welcome_email(@user).deliver
                # format.html { redirect_to(@user, notice: 'User was successfully created.') }
                # format.json { render json: @user, status: :created, location: @user }
            else
                render :index 
            end
    end

    def login  
        @pass = params[:password]
        
        # password = Digest::MD5.hexdigest(params[:password])
        # k =User.where(name: "#{params[:name]}", password: "#{password}")
        # if k.size == 0
        #      render :index
        # else
        #     redirect_to sig_in_path
        # end
    end 

    def destroy
        set_user.destroy
        respond_to do |format|
        format.html { redirect_to user_path, notice: "User was successfully destroyed." }
        format.json { head :no_content }
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
