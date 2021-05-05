class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = root_url
    mail(to: @user.email, subject: "Welcome to my Facebook clone.")
  end
end
