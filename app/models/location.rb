class Location < ActiveRecord::Base

	validates :street, :city, :state, presence: true

	geocoded_by :address, :latitude => :lat, :longitude => :lng
	
	after_validation :geocode

	def address
		[street, city, state, zipcode].compact.join(', ')
	end

end
