# app/controllers/custom_application_controller.rb
<<<<<<< HEAD
class ApplicationController <ActionController::API
	include JsonWebToken
	before_action :authenticate_request
	private

=======
class CustomApplicationController < ApplicationController
	include JsonWebToken
	before_action :authenticate_request
  
	private
  
>>>>>>> Master
	def authenticate_request
	  begin
		header = request.headers['Authorization']
		header = header.split(" ").last if header
		decoded = jwt_decode(header)
		@current_user = User.find(decoded[:user_id])
	  rescue JWT::DecodeError => e
		render json: { error: 'Invalid token' }, status: :unprocessable_entity
	  rescue ActiveRecord::RecordNotFound
		render json: "No record found.."
	  end
	end
<<<<<<< HEAD

	def current_user
	  @current_user
	end

=======
  
	def current_user
	  @current_user
	end
  
>>>>>>> Master
	def render_404
	  render json: { error: "Invalid URL" }, status: :not_found
	end
  end
<<<<<<< HEAD
=======
  
>>>>>>> Master
