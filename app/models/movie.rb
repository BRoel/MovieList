class Movie < ApplicationRecord
    has_many :comments, :dependent => :destroy
    has_many :lists, through: :comments
end
