class PartyIngredientsController < ApplicationController
    before_action :set_user_party, only: [:create]

  def create
    @party_ingredients = PartyIngredient.new(party_ingredients_params)
    @party_ingredients.user_party = @user_party
    if @party_ingredients.save
      redirect_to party_path(@user_party.party)
    end
  end

  def destroy
    @party_ingredient = PartyIngredient.find(params[:id])
    @party_ingredient.destroy
    redirect_to party_path(@party_ingredient.user_party.party)
  end

  private

  def set_user_party
     @user_party = UserParty.find(params[:user_party_id])
  end

  def party_ingredients_params
    params.require(:party_ingredient).permit(:name)
  end
end
