class AddDestIdToTrip < ActiveRecord::Migration
  def change
  	add_column :trips, :dest_id, :integer
  end
end
