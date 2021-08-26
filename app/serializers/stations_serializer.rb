class StationsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :distance, :status, :hours, :ev_network, :street_address, :city, :state, :zip_code
end
