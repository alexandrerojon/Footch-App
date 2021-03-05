class Party < ApplicationRecord
  belongs_to :user
  has_many :user_parties, dependent: :destroy
  has_many :party_ingredients, through: :user_parties
  has_many :party_recipes
  has_many :recipes, through: :party_recipes
  has_many :users, through: :user_parties
  has_many :messages, dependent: :destroy
end
