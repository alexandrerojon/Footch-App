class UsermailerMailer < ApplicationMailer
  def invitation
    
    @user = User.find_by(params[:id])
    @party = Party.find_by(params[:party_id])
   
      mail(to: @user.email, subject: "You were invited in the party of #{@user.username} !")
  end
end
