class LocationController < ApplicationController

	before_action :authenticate_with_token!

	def create
		name = params[:name]
		street = params[:street]
		city = params[:city]
		state = params[:state]
		zipcode = params[:zipcode]
		trip_id = params[:trip_id]

		@location = Location.new(name:name, street:street, city:city, state:state, zipcode:zipcode, trip_id:trip_id)

		if @location.save
			render json: @location, status: :created
		else
			render json: { errors: @location.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def index
		trip_id = params[:trip_id]
		trip = current_user.trips.find(trip_id)
		@locations = trip.locations
		render json: @locations, status: :ok
	end

end
