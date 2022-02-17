class ApplicationController < ActionController::Base
    helper_method :current_user
    
    # xac thuc dang nhap
    def current_user
        @current_user ||=User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
    end
    
end
