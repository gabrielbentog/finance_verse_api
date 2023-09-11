class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transaction_type
  delegate :category, to: :transaction_type
end
