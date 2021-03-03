class PartyIngredientsController < ApplicationController

  def create
    @party_ingredients = PartyIngredients.new
    @party_ingredients.party_id = params[:party_id]
    @party_ingredients.user = current.user
    @party_ingredients.save
  end
end
