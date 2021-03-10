class Recipe < ApplicationRecord
  validate :need_name, :need_steps, :need_ingredients, :need_image
  has_many :cookbooks, dependent: :destroy
  has_many :query_recipes, dependent: :destroy
  has_many :users, through: :cookbooks
  validates :name, presence: true
  has_many :party_recipes, dependent: :destroy
  belongs_to :user
  has_one_attached :picture


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
    if self.instructions.present?
      self.instructions[0]["steps"].each do |step|
        steps << step["step"]
      end
    end
    return steps
  end

  def serving
    serve = self.ingredients["servings"]
  end

  def servings
    ""
  end

  def readyInMinutes
    ""
  end

  def diets
    self.diet
  end

  def min
    time = self.ingredients["readyInMinutes"]
  end

  def diet
    self.ingredients.present? ? self.ingredients["diets"] : []
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

  def need_name
    errors.add(:name, "You need a recipe name!") if self.name.blank?
  end

  def need_image
    errors.add(:picture, "You need to add a picture!") if self.picture.blank? && self.image.blank?
  end

  def need_steps
   errors.add(:steps, "You need to add your instructions!") if self.steps.empty?
  end

  def need_ingredients
    errors.add(:ingredients, "You need to add your ingredients!") if self.ingredients.empty?
  end
end
