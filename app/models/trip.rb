class Trip < ActiveRecord::Base
	
  has_many :locations
  belongs_to :user
  has_one :origin, class_name: "Location"
  has_one :dest, class_name: "Location", foreign_key:"dest_id"

  def compare_times
  	locations = self.locations
  	directions = GoogleDirections.new(locations[0],locations[1])
  	directions.drive_time_in_minutes
  end

end
