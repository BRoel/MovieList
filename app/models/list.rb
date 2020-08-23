class List < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :movies, through: :comments
end
