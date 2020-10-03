class Movie < ApplicationRecord
    has_many :comments, :dependent => :destroy
    has_many :lists, through: :comments

    validates :title, :rating, :release_date, :genre, :description, presence: true
end
