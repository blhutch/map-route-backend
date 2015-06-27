class Trip < ActiveRecord::Base
	
  has_many :locations
  belongs_to :user
  has_one :origin, class_name: "Location"
  has_one :dest, class_name: "Location", foreign_key:"dest_id"

  def compare_times
  	google = GoogleDirections.new
    origin = self.locations.shift
  end

  def location_times(origin)
    location_pairs = self.locations.map do |location|
      [origin, location]
    end

    location_pairs.map do |x, y|
      Google.time_and_distance(x, y)
    end
  end

  def closest(origin)
    timings = self.location_times(origin)

  end

end
