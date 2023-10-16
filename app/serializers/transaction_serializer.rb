class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :date, :item_name, :amount
end
