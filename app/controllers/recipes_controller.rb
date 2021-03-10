class RecipesController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(picture: recipe_params[:picture])
    @recipe.name = params[:recipe][:name]
    ingredients = {}
    ingredients[:image] = nil
    ingredients[:servings] = params[:recipe][:servings]
    instructions = []
    instructions << { steps: [] }
    params[:recipe][:steps].each do |step|
      instructions.first[:steps] << { step: step } unless step.blank?
    end
    unless instructions.first[:steps].empty?
      instructions.first[:steps].first[:ingredients] = []
      params[:recipe][:ingredients].each do |ingredient|
        instructions.first[:steps].first[:ingredients] << { name: ingredient } unless ingredient.blank?
      end
    end
    diets = params[:recipe][:diets]
    diets.delete("")
    ingredients[:diets] = diets
    @recipe.instructions = instructions
    @recipe.ingredients = ingredients
    @recipe.user = current_user

    if @recipe.save
      current_user.recipes << @recipe
      redirect_to cookbooks_path, notice: "Your recipe has been added!"
    else
      render :new
    end
  end

  def recipe_params
    params.require(:recipe).permit(:picture)
  end
end
