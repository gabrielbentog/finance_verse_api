class TransactionType < ApplicationRecord
  belongs_to :category
  has_many :transactions

  validates :name, uniqueness: true
end
