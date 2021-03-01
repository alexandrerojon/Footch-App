class QueryRecipe < ApplicationRecord
  belongs_to :user_query
  belongs_to :recipe
end
