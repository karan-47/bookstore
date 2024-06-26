class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, presence: true, numericality: { only_integer: true, in: 1..5 }
  validates :review, presence: true
end
