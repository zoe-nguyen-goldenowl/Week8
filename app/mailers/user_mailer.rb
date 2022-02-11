class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def welcome_email user
    @user = user
    mail(to: @user.name, subject: 'Sample Email')	
  end

end
