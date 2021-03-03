class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 

  has_many :cookbooks, dependent: :destroy
  has_many :recipes, through: :cookbooks
  has_many :user_queries, dependent: :destroy
  has_many :created_parties, class_name: "Party"
  has_many :user_parties
  has_many :parties, through: :user_parties


end
