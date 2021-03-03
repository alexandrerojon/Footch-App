class UserQuery < ApplicationRecord
  belongs_to :user
  has_many :query_recipes
  has_many :recipes, through: :query_recipes

end
