class List < ApplicationRecord
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :movies, through: :comments

  scope :alpha, -> { order(:name) }
  scope :search, ->(params) { where("(name) LIKE ?", "%#{params}%")}
  validates :name, presence: true
end