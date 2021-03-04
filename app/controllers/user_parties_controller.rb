class UserPartiesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user_party = UserParty.new
    @user = User.find(params[:user_party][:user_id])
    @user_party.user = @user
    @user_party.party_id = params[:party_id]
    @user_party.save!
    @user.send_invitation_email
    redirect_to party_path(@user_party.party_id), notice: "Your friend has been added!"
  end

end
