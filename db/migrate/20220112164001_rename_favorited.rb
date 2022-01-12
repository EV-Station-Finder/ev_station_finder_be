class RenameFavorited < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_stations, :favorited?, :is_favorited
  end
end
