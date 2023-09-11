class CategorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :names, :transaction_types
end
