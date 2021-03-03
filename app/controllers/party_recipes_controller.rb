class PartyRecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_party_recipes, only: [:update]

  def create
    query_string = "instructionsRequired=true&addRecipeInformation=true&query=#{params.dig(:query, :ingredients
      ).join(",")}&diet=#{params.dig(:query,:diet)}"
    response = RestClient.get "https://api.spoonacular.com/recipes/complexSearch?#{query_string}",
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"] }
      }
    recipes = JSON.parse(response.body)
    @party_ingredients = PartyIngredients.new
    @party_ingredients.party.user = current_user
    @party_ingredients.name = "query name"
    @party_ingredients.save
    recipes["results"].each do |recipe_hash|
      recipe = Recipe.create!(
        name: recipe_hash["title"],
        ingredients: recipe_hash,
        instructions: recipe_hash["analyzedInstructions"],
        api_id: recipe_hash["id"]
        )
      @party_ingredients.recipes << recipe
      end
  end

  def update
    check_authorized(@party.user, current_user)
    @party_recipe.update(party_recipe_params)
    redirect_to parties_path(@party_recipe.activity)
  end

  private

  def party_recipe_params
    params.require(:party_recipe).permit(:chosen)
  end

  def set_party_recipes
    @party_recipe = PartyRecipe.find(params:id)
  end
end
