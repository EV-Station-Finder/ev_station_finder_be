class Dashboard
  attr_reader :id,
              :user,
              :nearest_stations,
              :favorite_stations
  def initialize(user, nearest_stations)
    @id = nil
    @user = user
    @nearest_stations = nearest_stations
    @favorite_stations = []
  end
end
