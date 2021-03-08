class UsersController < ApplicationController
  before_action :set_user, only: [:show]



  def show
    @username = @user.username
    @party = @user.created_parties
    @cookbooks = @user.cookbooks
  end



  private

  def set_user
    @user = User.find(params[:id])
  end

end
