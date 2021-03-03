class Recipe < ApplicationRecord

  has_many :cookbooks, dependent: :destroy
  has_many :query_recipes, dependent: :destroy
  has_many :users, through: :cookbooks
  validates :name, presence: true
  has_many :party_recipes, dependent: :destroy



  include PgSearch::Model
  pg_search_scope :search_by_name,
  against: [:name],
  using: {
  tsearch:{ prefix: true }
  }


  def image
    self.ingredients["image"]
  end

  def steps
    steps = []
    self.instructions[0]["steps"].each do |step|
       steps << step["step"]
    end
    return steps
  end

  def serving
    serve = self.ingredients["servings"]
    return "Number of servings: #{serve}"
  end

  def min
    time = self.ingredients["readyInMinutes"]
    return "Preparation time: #{time} minutes"
  end

  def diet
    self.ingredients["diets"]
  end

  def ingredients_list
    ingredients = []
    self.instructions[0]["steps"].each do |step|
      p step
      step["ingredients"]&.each do |ingredient|
        p ingredient
        ingredients << ingredient["name"]
      end
    end
    return ingredients.uniq
  end

  def summary
    self.ingredients["summary"].truncate_words(20).gsub!(/(<[^>]+>|&nbsp;|\r|\n)/,"")

  end
end
