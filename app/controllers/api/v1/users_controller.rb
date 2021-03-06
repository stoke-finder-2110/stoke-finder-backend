class Api::V1::UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    user.add_coordinates
    render(json: UserSerializer.new(user))
  end

  def create
    params[:user] = JSON.parse(request.raw_post)
    user = User.new(non_auth_user_params(params[:user]))
    if user.save
      user.add_coordinates
      user.oauth = false
      json_response(UserSerializer.new(user), :created)
    else
      render json: { status: 400, message: "#{user.errors.full_messages.to_sentence}", data: user.errors}, status: :bad_request
    end
  end

  def update
    non_auth_user_params = JSON.parse(request.raw_post)
    user = User.update(non_auth_user_params["id"], non_auth_user_params)
    if params[:id].to_i != non_auth_user_params["id"]
      render json: { status: "ERROR", message: "User ID does not match a current user.", data: user.errors}, status: :bad_request
    elsif user.save
      user.add_coordinates
      json_response(UserSerializer.new(user))
    else
      render json: { status: "ERROR", message: "#{user.errors.full_messages.to_sentence}", data: user.errors}, status: :bad_request
    end
  end

  def destroy
    User.find(params[:id]).delete
    render json: {message: "Account successfully deleted.", status: 200}
  end

  private
  def non_auth_user_params(user_params)
    if user_params["activity_preferences"].class == Array
      user_params["activity_preferences"] = user_params["activity_preferences"].join(" ")
    end
    params[:user].permit(:user_name, :email, :password, :password_confirmation, :access, :street_address, :city, :state, :zipcode, :activity_preferences)
  end

  def outh_user
    dlfkjsldkfjs
  end
end
