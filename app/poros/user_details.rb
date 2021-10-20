class UserDetails
  attr_reader :token,
              :email,
              :street_address,
              :city,
              :state,
              :zip_code
  def initialize(user)
    @token = JWT.encode({user_id: user[:id]}, 'hasselhoff', 'HS256')
    @email = user["email"]
    @street_address = user["street_address"]
    @city = user["city"]
    @state = user["state"]
    @zip_code = user["zip_code"]
  end
end
