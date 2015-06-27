class AddOrigIdToLocation < ActiveRecord::Migration
  def change
  	add_column :locations, :origin_id, :integer
  	add_column :locations, :dest_id, :integer
  end
end
