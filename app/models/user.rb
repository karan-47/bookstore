class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :password, presence: true, length: {minimum: 4, maximum: 8}
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, :uniqueness => {:message => "Email already exists."}, format: { with: VALID_EMAIL_REGEX }
  VALID_CREDIT_CARD_REGEX = /\A[\d][\d-]*[\d]\z/i
  validates :creditcardnumber, length: {is: 16}, format: { with: VALID_CREDIT_CARD_REGEX }, allow_nil: true, allow_blank: true

  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy

end