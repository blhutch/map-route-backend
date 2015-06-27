class RemoveOrigIdFromTrip < ActiveRecord::Migration
  def change
  	remove_column :trips, :origin_id
  	remove_column :trips, :dest_id
  end
end
