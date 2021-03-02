class UserQueriesController < ApplicationController

  def new
  end

  def create
    response = RestClient.get 'https://api.spoonacular.com/recipes/complexSearch',
      {
        params: {"apiKey" => ENV["API_KEY_SPOON"], addRecipeInformation: true,
         includeIngredients: params.dig(:query, :ingredients), number: 1, diet: params.dig(:query, :diet)}
      }
    recipes = JSON.parse(response.body)
    raise
  end

  def show
  end

  def index
  end
end

