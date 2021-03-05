class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :destroy]

  def index
    @parties = current_user.parties
  end

  def show
    @new_user_party = UserParty.new
    @party_ingredient = PartyIngredient.new
    @user_party = UserParty.find_by(user: current_user, party: @party)
    @message = Message.new
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)
    @party.user = current_user

    if @party.save!
      @party.users << current_user
      redirect_to @party, notice: "Your party has been created"
    else
      render :new
    end

  end

  def destroy
    @party = Party.find(params[:id])
    @party.destroy
    redirect_to parties_path, notice: 'This party was succesfully deleted.'
  end

  private

  def set_party
    @party = Party.find(params[:id])
  end

  def party_params
    params.require(:party).permit(:name, :date)
  end
end
