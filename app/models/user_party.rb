class UserParty < ApplicationRecord
  belongs_to :party
  belongs_to :user
  has_many :party_ingredients
end
