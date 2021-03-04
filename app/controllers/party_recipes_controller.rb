class PartyRecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_party_recipes, only: [:update]
  before_action :set_party

  def create
    query_string = "instructionsRequired=true&addRecipeInformation=true&query=#{ @party.party_ingredients.map{ |ingredient| ingredient.name}.join(",").delete(" ")}"
    p query_string

    response = RestClient.get "https://api.spoonacular.com/recipes/complexSearch?#{query_string}",
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"] }
      }
    recipes = JSON.parse(response.body)
    p recipes



    recipes["results"].each do |recipe_hash|
      recipe = Recipe.create!(
        name: recipe_hash["title"],
        ingredients: recipe_hash,
        instructions: recipe_hash["analyzedInstructions"],
        api_id: recipe_hash["id"]
        )
      @party.recipes << recipe
      end
      redirect_to party_path(@party)
  end

  def update
    check_authorized(@party, current_user)
    @party_recipe.update(party_recipe_params)
    redirect_to party_path(@party)
  end

  private

  def party_recipe_params
    params.require(:party_recipe).permit(:chosen)
  end

  def set_party_recipes
    @party_recipe = PartyRecipe.find(params[:id])
  end

  def set_party
    @party = Party.find(params[:party_id])
  end
end
