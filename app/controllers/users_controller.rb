class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index create login]
  skip_before_action :check_owner
  skip_before_action :check_customer
  skip_before_action :verify_authenticity_token
  # has_secure_password

  def index
    users = User.all
    render json: users
  end

  def login
    if user = User.find_by(email: params[:email], password: params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { message: 'Logged In Successfully..', token: token }
    else
      render json: { error: 'Please Check your Email And Password.....' }
    end
  end
end
