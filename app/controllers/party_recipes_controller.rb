class PartyRecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_party_recipes, only: [:update, :voting, :destroy]
  before_action :set_party, except: [:voting, :destroy]

  def create
    #query 1 by ingredients from party
    query_string = "number=25&ignorePantry=true&ranking=1&ingredients=#{ @party.party_ingredients.map{ |ingredient| ingredient.name}.join(",").delete(" ")}"
    response = RestClient.get "https://api.spoonacular.com/recipes/findByIngredients?#{query_string}",
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"] }
      }
    recipes_by_ingredients = JSON.parse(response.body)
    @ids = []
    recipes_by_ingredients.each do |recipe|
      @ids << recipe["id"].to_s
    end

    #query 2 by ids from party
    query_id = "ids=#{(@ids).join(",")}"
    response = RestClient.get "https://api.spoonacular.com/recipes/informationBulk?#{query_id}",
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"] }
      }
    recipe_found_by_ids = JSON.parse(response.body)

    #creating the party recipe from the has
    recipe_found_by_ids.each do |recipe_hash|
      next unless recipe_hash["analyzedInstructions"].present? && recipe_hash["analyzedInstructions"][0]["steps"].present? && recipe_hash["image"].present?
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

  def destroy
    if @party_recipe.party.user == current_user && @party_recipe.destroy
      redirect_to party_path(@party_recipe.party), notice: 'This recipe was succesfully removed.'
    else
      redirect_to party_path(@party_recipe.party), notice: 'You need to be the admin!'
    end
  end

  def voting
    if @party_recipe.party.users.include?(current_user)
      @party_recipe.liked_by current_user
    end
    redirect_to party_path(@party_recipe.party)
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
