class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :list
  belongs_to :movie
end
