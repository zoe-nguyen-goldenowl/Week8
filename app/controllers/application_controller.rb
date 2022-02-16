class ApplicationController < ActionController::Base
    #  attr_reader :current_user

    # xac thuc dang nhap
    helper_method :current_user
    def current_user
        @current_user ||=User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]

    end
    
    # def logged_in?
    # !!current_user
    # end
    
    # def require_user
    #     if !logged_in?
    #         flash[:alert] = "You must be logged in to perform that action."
    #         redirect_to sign_in_path
    #     end
    # end
     

    # protected
    # def authenticate_request!
    #     unless user_id_in_token?
    #     render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    #     return
    #     end
    #     @current_user = User.find(auth_token[:user_id])
    #     rescue JWT::VerificationError, JWT::DecodeError
    #     render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    # end

    # private
    # def http_token
    #     @http_token ||= if request.headers['Authorization'].present?
    #         request.headers['Authorization'].split(' ').last
    #     end
    # end

    # def auth_token
    #     @auth_token ||= JsonWebToken.decode(http_token)
    # end

    # def user_id_in_token?
    #     http_token && auth_token && auth_token[:user_id].to_i
    # end
end
