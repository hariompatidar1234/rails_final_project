class OwnersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :check_customer
  skip_before_action :check_owner, only: [:create]
  skip_before_action :verify_authenticity_token
  # has_secure_password

  def create
    owner = Owner.new(owner_params)
    if owner.save
      render json: { message: 'Owner Created', data: owner }
    else
      render json: { error: 'Registration failed' }
    end
  end

  def destroy
    if current_user.destroy
      render json: { message: 'Owner  deleted' }, status: :no_content
    else
      render json: { message: 'Owner deletion failed' }
    end
  end

  private

  def owner_params
    params.permit(:name, :email, :password)
  end
end
