class PartyIngredientsController < ApplicationController

  def create
    @user_party = UserParty.find(params[:user_party_id])
    @party_ingredients = PartyIngredient.new(party_ingredients_params)
    @party_ingredients.user_party = @user_party
    if @party_ingredients.save
      redirect_to party_path(@user_party.party)
    end
  end

  private

  def party_ingredients_params
    params.require(:party_ingredient).permit(:name)
  end
end
