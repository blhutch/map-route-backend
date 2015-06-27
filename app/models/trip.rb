class Trip < ActiveRecord::Base
	
  has_many :locations
  belongs_to :user
  has_one :origin, class_name: "Location"
  has_one :dest, class_name: "Location", foreign_key:"dest_id"

  def best_route
  	google = GoogleDirections.new
  	waypoints = self.locations.to_a
    origin = waypoints.shift
    distances = location_distances(origin,waypoints)
    best_time(distances)
  end

  def location_times(origin,waypoints)
    location_pairs = waypoints.map {|loc| [origin, loc] }
  	get_times(location_pairs)
  end

  def location_distances(origin,waypoints)
  	location_pairs = waypoints.map {|loc| [origin, loc] }
  	get_distances(location_pairs)
  end

  def get_times(location_pairs)
  	google = GoogleDirections.new
  	location_pairs.map do |x, y|
      location1 = "#{x["lat"]},#{x["lng"]}"
      location2 = "#{y["lat"]},#{y["lng"]}"
      duration = google.duration(location1, location2)
      [y["id"], duration[:duration]]
    end
  end

  def get_distances(location_pairs)
  	google = GoogleDirections.new
  	location_pairs.map do |x, y|
      location1 = "#{x["lat"]},#{x["lng"]}"
      location2 = "#{y["lat"]},#{y["lng"]}"
      distance = google.distance(location1, location2)
      [y["id"], distance[:distance]]
    end
  end

  def best_time(times)
   	just_times = times.map {|x,y| y}
   	just_times.each_with_index.min.reverse
  end

end
