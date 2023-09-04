class Crypto < ApplicationRecord
  has_many :user_cryptos
  has_many :users, through: :user_cryptos
end
