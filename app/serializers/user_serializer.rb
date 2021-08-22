class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :role
  # has_many :blogs
end
