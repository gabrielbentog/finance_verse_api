class TransactionType < ApplicationRecord
  belongs_to :category
  has_many :transactions
end
