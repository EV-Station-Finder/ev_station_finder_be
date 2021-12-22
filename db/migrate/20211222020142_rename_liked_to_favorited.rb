class RenameLikedToFavorited < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_stations, :liked?, :favorited?
  end
end
