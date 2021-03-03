class RecipesController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
  end

  def create
    #saving recipe with current user ID
    @recipe = Recipe.new
    @recipe.name = params[:user_recipe][:name]
    ingredients = {}
    ingredients[:image] = "https://picsum.photos/200/300/?blur"
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
    @recipe.instructions = instructions
    @recipe.ingredients = ingredients
    @recipe.save
    redirect_to recipe_path(@recipe), notice: "Your recipe has been added!"
  end
end
