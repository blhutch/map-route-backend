class Location < ActiveRecord::Base

	geocoded_by :address, :latitude => :lat, :longitude => :lng

	def address
		[street, city, state, zipcode].compact.join(', ')
	end

end
