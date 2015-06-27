class UsersController < ApplicationController
	 before_action :authenticate_with_token!, except: [:register, :login]

	def register
	 	password = params[:password]
    username = params[:username]
    email = params[:email]
    if password && username && email
      passhash = Digest::SHA1.hexdigest(password)
      @user = User.new(username: username, email: email, password: passhash)
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
