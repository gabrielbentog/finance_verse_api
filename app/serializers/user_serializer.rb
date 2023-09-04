class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :auth_token
end
