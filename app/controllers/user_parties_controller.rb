class UserPartiesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user_party = UserParty.new
    @user = User.find(params[:user_party][:user_id])
    @user_party.user = @user
    @user_party.party_id = params[:party_id]
    @user_party.status = "pending"
    @user_party.save!
    @user.send_invitation_email(@user_party.party)

    redirect_to party_path(@user_party.party_id), notice: "Your friend has been added!"
  end

  def update
    @user_party = UserParty.find(params[:id])
    @user_party.update(user_party_params)
    redirect_to party_path(@user_party.party)
  end

  private

  def user_party_params
    params.require(:user_party).permit(:party_id, :user_id, :status)
  end
end
