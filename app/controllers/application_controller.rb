class ApplicationController < ActionController::Base
	include JsonWebToken
	before_action :authenticate_request
	before_action :check_owner
	before_action :check_customer
	
	private
	
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
	
	def current_user
		@current_user
	end
	
	def check_owner
		if @current_user.type != 'Owner'
			render json: { message: "You are not an owner" }, status: :unauthorized
		end
	end
	
	def check_customer
		if @current_user.type != 'Customer'
			render json: { message: "You are not a customer" }, status: :unauthorized
		end
	end
	
	def render_404
		render json: { error: "Invalid URL" }, status: :not_found
	end
end
