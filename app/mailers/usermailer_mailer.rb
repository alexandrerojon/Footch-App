class UsermailerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  #
  ##{current_user.username}
  #   @user = params[:user]
  # perhaps put user as a parameter of the method and put  inside it in place of lane 9
  def invitation
    @user = params[:user]

    mail(to: @user.email, subject: "You were invited in the party of  !")
  end
end
