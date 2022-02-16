require 'digest'
class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def check_password user
    @user = user
    mail(to: @user.name, subject: 'Sample Email')	
  end

  def welcome_email user
    @user = user
    @user.token =  Digest::MD5.hexdigest(@user.name)
    mail(to: @user.name, subject: 'Sample Email')	
  end

end
