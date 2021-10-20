class DashboardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user, :nearest_stations, :favorite_stations
end
