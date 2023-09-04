class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  def self.serialize(errors)
    { errors: errors }
  end 
end
