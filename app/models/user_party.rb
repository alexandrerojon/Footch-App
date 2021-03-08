class UserParty < ApplicationRecord
  belongs_to :party
  belongs_to :user
  has_many :party_ingredients, dependent: :destroy
  STATUS = ["pending", "attending", "not attending"]
  validates :status, inclusion: { in: STATUS }
end
