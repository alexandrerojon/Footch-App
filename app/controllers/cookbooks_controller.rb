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
      @recipes = current_user.recipes.search_by_name(params[:query]).order(created_at: :desc)
    else
      @recipes = current_user.recipes.order(created_at: :desc)
    end
  end

  def destroy
    @cookbook = current_user.cookbooks.find_by(recipe_id: params[:id])
    if @cookbook.user == current_user
      @cookbook.destroy
      redirect_to cookbooks_path, notice: 'This recipe was succesfully removed.'
    else
      redirect_to cookbooks_path, notice: "You can't removed it's not your cookbook."
    end
  end

  private

  def cookbook_params
    params.require(:cookbook).permit(:current_user, :recipe_id)
  end
end
