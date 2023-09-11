class Category < ApplicationRecord
  has_many :transaction_types
  has_many :transactions, through: :transaction_types
end
