class Api::V1::UsersController < ApplicationController

  def show
  user = User.find(params[:id])
  user.add_coordinates
  render(json: UserSerializer.new(user))
  end

  def create
    user = User.create!(non_auth_user_params)
    if user.save
      user.add_coordinates
      json_response(UserSerializer.new(user), :created)
    else
      render json: { status: 'ERROR', message: "#{user.errors.to_sentence}", data: user.errors}, status: :bad_request
    end
    #add_coordinates will need to happen here
    #Conditional for Oauth user or non-oauth
    #if oauth
      #oauth params
    #end
  end

  def edit

  end

  private
  def non_auth_user_params
    params["user"]["activity_preferences"] = params["user"]["activity_preferences"].join(" ")
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :access, :street_address, :city, :state, :zipcode, :activity_preferences)
  end

  def outh_user
    dlfkjsldkfjs
  end
end
