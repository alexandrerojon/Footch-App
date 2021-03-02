class UserQueriesController < ApplicationController

  def new
  end

  def create
    response = RestClient.get 'https://api.spoonacular.com/recipes/complexSearch',
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"], addRecipeInformation: true,
         includeIngredients: params.dig(:query, :ingredients), number: 10, diet: params.dig(:query, :diet)}
      }
    recipes = JSON.parse(response.body)

    @user_query = UserQuery.new
    @user_query.user = current_user
    @user_query.name = "query name"
    @user_query.save
    recipes["results"].each do |recipe_hash|
      recipe = Recipe.create!(
        name: recipe_hash["title"],
        ingredients: recipe_hash,
        instructions: recipe_hash["analyzedInstructions"],
        api_id: recipe_hash["id"]
        )
      @user_query.recipes << recipe
    end
    redirect_to user_query_path(@user_query)
  end

  def show

  end

  def index
  end

end

