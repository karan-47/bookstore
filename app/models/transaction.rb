class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :totalprice, presence: true
end
