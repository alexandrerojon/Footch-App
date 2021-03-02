class UserQuery < ApplicationRecord
  belongs_to :user
  has_many :query_recipes
  has_many :recipes, through: :query_recipes
  
  def image
    self.ingredients["image"]
    
  end

  def subject
    name = self.ingredients["title"]
    return "#{name}"
  end 
end
