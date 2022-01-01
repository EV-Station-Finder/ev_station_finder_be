class StationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :api_id, :status, :hours, :ev_network, :ev_connector_types, :street_address, :city, :state, :zip_code, :is_favorited, :accepted_payments, :hourly_weather
end
