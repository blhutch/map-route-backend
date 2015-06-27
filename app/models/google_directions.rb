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

	def parse_directions(directions)
		elements = directions["rows"][0]["elements"][0]
		{
			distance: elements["distance"]["text"].split(" ").first.to_f,
			duration: elements["duration"]["text"].split(" ").first.to_f
		}
	end

	def time_and_distance(origin,destination)
		directions = get_directions(origin,destination)
		parse_directions(directions)
	end



end