class CookbooksController < ApplicationController


  def create
    @cookbook = Cookbook.new
    @cookbook.user_id = current_user[:id]
    @cookbook.recipe_id = params[:recipe_id]
    @cookbook.save!
    redirect_to cookbooks_path, notice: "The recipe was added to your cookbook!"

  end

  def index
    if params[:query].present?
      @recipes = current_user.recipes.search_by_name(params[:query])
    else
      @recipes = current_user.recipes
    end
  end

  def destroy
    @cookbook = Cookbook.find(params[:id])
    Cookbook.destroy
    redirect_to cookbook_path, notice: 'This receipe was succesfully removed.'
  end

  private

  def cookbook_params
    params.require(:cookbook).permit(:current_user, :recipe_id)
  end

end
