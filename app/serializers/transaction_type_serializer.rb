class TransactionTypeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
