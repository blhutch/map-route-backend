class Trip < ActiveRecord::Base
	
  has_many :locations
  belongs_to :user
  has_one :origin, class_name: "Location"
  has_one :dest, class_name: "Location", foreign_key:"dest_id"

  def compare_times
  	google = GoogleDirections.new
    origin = self.locations.shift
    times = location_times(origin)
  end

  def location_times(origin)
    location_pairs = self.locations.map do |location|
      [origin, location]
    end

    location_pairs.map do |x, y|
      location1 = "#{x["lat"]},#{x["lng"]}"
      location2 = "#{y["lat"]},#{y["lng"]}"
      
      [y["id"], Google.time_and_distance(location1, location2)]
    end
  end

  def closest(origin)
    timings = self.location_times(origin)
  end

  def best_time(times)
    times.select {|x,y|  == "duration"}.min
  end

end
