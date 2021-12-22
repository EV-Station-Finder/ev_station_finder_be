class AddDefaultValueToLikedAttribute < ActiveRecord::Migration[5.2]
  def change
    change_column :user_stations, :liked?, :boolean, default: true
  end
end
