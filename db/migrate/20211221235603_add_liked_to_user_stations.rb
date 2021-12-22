class AddLikedToUserStations < ActiveRecord::Migration[5.2]
  def change
    add_column :user_stations, :liked?, :boolean
  end
end
