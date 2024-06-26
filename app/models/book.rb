class Book < ApplicationRecord

  validates :name, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :stock, presence: true, numericality: { only_integer: true }

  has_many :reviews, dependent: :delete_all
  has_many :transactions, dependent: :delete_all

  BOOK_FILTERS = %w[name author publisher price stock]

  scope :filter_by_name, -> (name) { where("name like ?", "#{name}%")}
  scope :filter_by_author, -> (author) { where("author like ?", "#{author}%")}
  scope :filter_by_publisher, -> (publisher) { where("publisher like ?", "#{publisher}%")}
  scope :filter_by_price, -> (price) { where price: price }
  scope :filter_by_stock, -> (stock) { where stock: stock }
  # scope :filter_by_average_rating, -> (average_rating) { where("average_rating > ?", average_rating) }

end