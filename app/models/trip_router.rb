class TripRouter

	attr_reader :route

	def initialize(locations_array)
		locations_array = locations_array.to_a
		@google = GoogleDirections.new
		@origin = locations_array.shift
		@waypoints = locations_array
		@route = []
	end

	def choose_best_route
		route1 = optimize_shortest_distance
		route2 = optimize_longest_first

		if route1[0][:trip_time] > route2[0][:trip_time]
			route2
		else
			route1
		end

	end

	def optimize_shortest_distance
		@route << [@origin["id"],0,0]
		until @waypoints.length == 0 
			distances = get_distance_and_duration
			shortest = min_dist(distances)
			remove_route(shortest)
		end
		id_to_location
	end

	def optimize_longest_first
		@route << [@origin["id"],0,0]
		orig_length = @waypoints.length
		until @waypoints.length == 0
			distances = get_distance_and_duration
			if @waypoints.length == orig_length
				longest = max_dist(distances)
				remove_route(longest)
			else
				shortest = min_dist(distances)
				remove_route(shortest)
			end
		end
		id_to_location
	end

	def remove_route(array)
		@route << array
		@origin = Location.find(array.first)
		@waypoints -= [@origin]
	end

	def id_to_location
		time = 0
		route = []
		@route.each do |x,y,z|
  		location = Location.find(x)
  		time += z
  		route << {
  			name: location["name"],
  			address: location.address,
  			distance_to: y,
  			time_to: z,
  			lat: location["lat"],
  			lng: location["lng"]
  		}
  	end
  	route.unshift({trip_time: time})
  	route
  end

	def pair_origin_with_waypoint
		@waypoints.map {|loc| [@origin, loc] }
	end

	def get_distance_and_duration
		pairs = pair_origin_with_waypoint
		pairs.map do |x,y|
			location1 = "#{x["lat"]},#{x["lng"]}"
      location2 = "#{y["lat"]},#{y["lng"]}"
      attributes = @google.distance_and_duration(location1, location2)
      [y["id"], attributes].flatten
    end
  end

	def get_min(nested_array)
		nested_array.min_by {|x,y| y}
	end

	def max_dist(nested_array)
		nested_array.max_by {|x,y,z| y}
	end

	def min_dist(nested_array)
		nested_array.min_by {|x,y,z| y}
	end

	def min_time(nested_array)
		nested_array.min_by {|x,y,z| z}
	end

end