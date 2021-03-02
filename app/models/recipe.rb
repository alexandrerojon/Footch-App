class Recipe < ApplicationRecord

  has_many :cookbooks
  has_many :query_recipes
  has_many :users, through: :cookbooks

  include PgSearch::Model
  pg_search_scope :search_by_name,
  against: [:name],
  using: {
  tsearch:{ prefix: true }
  }

end
