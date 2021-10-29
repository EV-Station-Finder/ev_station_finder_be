class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :email, :street_address, :city, :state, :zip_code

  set_id { nil }

end
