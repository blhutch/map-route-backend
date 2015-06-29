class GoogleDirections

	include HTTParty
	
	base_uri 'https://maps.googleapis.com/maps/api/distancematrix'

	def initialize 
		@token = ENV['GOOGLE_API_KEY']
	end

	def get_directions(origin,destination)

		@options = { 
			query: {
				origins: origin,
				destinations: destination,
				units: "imperial",
				key: @token
			}
		}

		self.class.get("/json", @options)

	end

	def parse_distance(directions)
		elements = directions["rows"][0]["elements"][0]
		elements["distance"]["text"].split(" ").first.to_f
	end

	def parse_duration(directions)
		elements = directions["rows"][0]["elements"][0]
		elements["duration"]["text"].split(" ").first.to_f
	end

	def parse_distance_and_duration(directions)
		elements = directions["rows"][0]["elements"][0]
		distance = elements["distance"]["text"].split(" ").first.to_f
		duration = elements["duration"]["text"].split(" ").first.to_f
		[distance, duration]
	end


	def duration(origin,destination)
		directions = get_directions(origin,destination)
		parse_duration(directions)
	end

	def distance(origin,destination)
		directions = get_directions(origin,destination)
		parse_distance(directions)
	end

	def distance_and_duration(origin,destination)
		directions = get_directions(origin,destination)
		parse_distance_and_duration(directions)
	end



end