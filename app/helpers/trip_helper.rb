module TripHelper
	
	def compare_times(trip)
		locations = trip.locations
		direction = GoogleDirections.new(locations[0], @locations[1])
		directions.drive_time_in_minutes
	end

	def compare_distance

	end

	def hello
		"hello"
	end


end
