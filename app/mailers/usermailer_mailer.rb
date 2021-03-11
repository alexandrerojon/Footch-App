class UsermailerMailer < ApplicationMailer
  def invitation

    @user = params[:user]
    @party = params[:party]
    mail(to: @user.email, subject: "You were invited in the party of #{@party.user.username} !")
  end
end
