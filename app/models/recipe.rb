class Recipe < ApplicationRecord

  has_many :cookbooks
  has_many :query_recipes
  has_many :users, through: :cookbooks

end
