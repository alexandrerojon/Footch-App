class UserQueriesController < ApplicationController

  def new
  end

  def create
    #query 1 by ingredients
    query_string = "ingredients=#{params.dig(:query, :ingredients).join(",")}"
    response = RestClient.get "https://api.spoonacular.com/recipes/findByIngredients?#{query_string}",
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"] }
      }
    rfi = JSON.parse(response.body)
    @ids = []
    rfi.each do |recipe|
      @ids << recipe["id"].to_s
    end

    #query 2 by id's
    query_id = "ids=#{(@ids).join(",")}"
    response = RestClient.get "https://api.spoonacular.com/recipes/informationBulk?#{query_id}",
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"] }
      }
    rfid = JSON.parse(response.body)

    raise


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
