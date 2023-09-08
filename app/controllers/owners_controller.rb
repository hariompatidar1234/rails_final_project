class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update, :destroy]
<<<<<<< HEAD
    skip_before_action :authenticate_request, only: :create
=======
  load_and_authorize_resource # Load the owner and authorize actions using CanCanCan
>>>>>>> Master

  def create
    @owner = Owner.new(owner_params) # Load a new owner
    if @owner.save
<<<<<<< HEAD
      render json: { message: 'Owner Created' }
=======
      render json: { message: 'Owner Created', data: @owner }
>>>>>>> Master
    else
      render json: { error: 'Registration failed' }, status: :unprocessable_entity
    end
  end

  def show
    render json: @owner
  end

  def update
    if @owner.update(owner_params)
      render json: { message: 'Owner updated' }
    else
      render json: { errors: @owner.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @owner.destroy
      render json: { message: 'Owner deleted' }, status: :no_content
    else
      render json: { message: 'Owner deletion failed' }
    end
  end

  private

  def owner_params
    params.permit(:name, :email, :password)
  end

  def set_owner
<<<<<<< HEAD
    @owner = Owner.find_by(name: params[:owner_name])
=======
    @owner = Owner.find_by(id: params[:id])
>>>>>>> Master
    render json: { message: 'Owner not found' }, status: :not_found unless @owner
  end
end
