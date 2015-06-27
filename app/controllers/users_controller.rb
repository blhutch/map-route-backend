class UsersController < ApplicationController
	 before_action :authenticate_with_token!, except: [:register, :login]

	def register
    street = params[:street]
    city = params[:city]
    state = params[:state]
    zipcode = params[:zipcode]
	 	password = params[:password]
    username = params[:username]
    email = params[:email]

    if password && username && email && street && city && state && zipcode
      passhash = Digest::SHA1.hexdigest(password)
      home = Location.create(street:street, city:city, state:state, zipcode:zipcode)
      @user = User.new(username: username, email: email, password: passhash, home:home)
      if @user.save
        render "register.json.jbuilder", status: :created
      else
        render json: { errors: @user.errors.full_messages },
          status: :unprocessable_entity
      end
    else
      render json: {msg: "Please provide username, password, and email."}, status: :unprocessable_entity
    end

	end

	def login
		 passhash = Digest::SHA1.hexdigest(params[:password])
    @user = User.find_by(username: params[:username])
    if @user && @user.password == passhash
      render "login.json.jbuilder"
    else
      render json: { msg: "User is not authenticated" }, status: :unauthorized
    end
	end

end
