class Movie < ApplicationRecord
    has_many :comments
    has_many :lists, through: :comments
end
