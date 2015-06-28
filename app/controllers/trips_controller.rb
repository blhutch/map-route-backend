class TripsController < ApplicationController

	before_action :authenticate_with_token!

	def create
		title = params[:title]
		binding.pry

		unless params[:custom]
			origin = current_user.home
		end

		@trip = Trip.new(title: title, user: current_user, origin:origin)

		if @trip.save
			render json: @trip, status: :created
		else
			render json: { errors: @trip.errors.full_messages }, status: :unprocessable_entity
		end

	end

	def index
		@trips = current_user.trips
		render json: @trips, status: :ok
	end

	def optimize
		trip = Trip.find(params[:trip_id])
		router = TripRouter.new(trip.locations)
		@optimal_route = router.optimize_shortest_distance
		render json: @optimal_route
	end
  
end
