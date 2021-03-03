class UserQueriesController < ApplicationController

  def new
  end

  def create
    query_string = "instructionsRequired=true&addRecipeInformation=true&query=#{params.dig(:query, :ingredients
      ).join(",")}&diet=#{params.dig(:query,:diet)}"
    response = RestClient.get "https://api.spoonacular.com/recipes/complexSearch?#{query_string}",
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"] }
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
      @user_query = UserQuery.find(params[:id])
  end

  def index
  end


end

