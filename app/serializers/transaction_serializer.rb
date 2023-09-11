class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :item_name, :amount
end
