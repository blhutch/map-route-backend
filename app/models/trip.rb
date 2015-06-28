class Trip < ActiveRecord::Base
	
  has_many :locations
  belongs_to :user
  has_one :origin, class_name: "Location"
  has_one :dest, class_name: "Location", foreign_key:"dest_id"

  def best_route
  	waypoints = self.locations.to_a
  	origin = waypoints.shift
  	route = [[origin["id"],nil]]
  	until waypoints.length == 0
	    distances = location_distances(origin,waypoints)
	    best_time = best_time(distances)
	    route << best_time
	    origin = Location.find(best_time[0])
	    waypoints = waypoints - [origin]
	  end
	  id_to_location(route)
  end

  def id_to_location(route)
  	route.map do |x,y|
  		location = Location.find(x)
  		{
  			name: location["name"],
  			address: location.address,
  			distance_to: y,
  			lat: location["lat"],
  			lng: location["lng"]
  		}
  	end
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
      [y["id"], duration]
    end
  end

  def get_distances(location_pairs)
  	google = GoogleDirections.new
  	location_pairs.map do |x, y|
      location1 = "#{x["lat"]},#{x["lng"]}"
      location2 = "#{y["lat"]},#{y["lng"]}"
      distance = google.distance(location1, location2)
      [y["id"], distance]
    end
  end

  def best_time(times)
   	times.min_by {|x,y| y}
  end

end
