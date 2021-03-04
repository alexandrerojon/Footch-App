class PartyRecipe < ApplicationRecord
  belongs_to :party
  belongs_to :recipe

  acts_as_votable
end
