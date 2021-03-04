class PartiesController < ApplicationController

  before_action :set_party, only: [:show, :destroy]

  def index
    @parties = Party.all
  end

  def show
    @party_ingredient = PartyIngredient.new
    @user_party = UserParty.find_by(user: current_user, party: @party)
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)
    @party.user = current_user
    
    if @party.save!
      redirect_to @party, notice: " Party created"
    else 
      render :new
    end 
  end


  def destroy
    @party.destroy
  end

  private

  def set_party
    @party = Party.find(params[:id])
  end

  def party_params
    params.require(:party).permit(:name, :date)
  end
end
