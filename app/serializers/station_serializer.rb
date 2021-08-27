class StationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :api_id, :status, :hours, :ev_network, :street_address, :city, :state, :zip_code, :accepted_payments, :hourly_weather
end
