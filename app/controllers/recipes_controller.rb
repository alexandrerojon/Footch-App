class RecipesController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
  end

  def create
    @recipe = Recipe.new(picture: recipe_params[:picture])
    @recipe.name = params[:user_recipe][:name]
    ingredients = {}
    ingredients[:image] = nil
    ingredients[:servings] = params[:user_recipe][:servings]
    instructions = []
    instructions << { steps: [] }
    params[:user_recipe][:steps].each do |step|
      instructions.first[:steps] << { step: step } unless step.blank?
    end
    instructions.first[:steps].first[:ingredients] = []
    params[:user_recipe][:ingredients].each do |ingredient|
      instructions.first[:steps].first[:ingredients] << { name: ingredient } unless ingredient.blank?
    end
    diets = params[:user_recipe][:diets]
    diets.delete("")
    ingredients[:diets] = diets
    @recipe.instructions = instructions
    @recipe.ingredients = ingredients
    @recipe.user_id = current_user.id
    @recipe.save

    current_user.recipes << @recipe

    redirect_to cookbooks_path, notice: "Your recipe has been added!"
  end

  def recipe_params
    params.require(:user_recipe).permit(:picture)
  end
end
