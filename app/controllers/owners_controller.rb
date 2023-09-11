class OwnersController < ApplicationController
  before_action :set_owner, only: %i[show update destroy]
  before_action :authenticate_request, except: :create


  def create
    @owner = Owner.new(owner_params) # Load a new owner
    if @owner.save
      render json: { message: 'Owner Created' }
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
    @owner = Owner.find_by_name(params[:owner_name])
    render json: { message: 'Owner not found' }, status: :not_found unless @owner
  end
end
