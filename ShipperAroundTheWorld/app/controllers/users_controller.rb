class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: :destroy

	def index
		@users = User.paginate(page: params[:page], :per_page => 8)
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@requests = @user.requests.paginate(page: params[:page], :per_page => 6)
		@request = current_user.requests.build
		@message = Message.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			#@user.send_activation_email
			#flash[:info] = "Please check your email to activate your account."
			#redirect_to root_url
			log_in @user
			flash[:success] = "Welcome to SAW"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@messages = @user.messages
		@messages.each do |mess|
			mess.destroy
		end
		@requests = @user.requests
		@requests.each do |request|
			@request = Request.find_by(id: request.id)
			@messages = @request.messages
			@contract = @request.contract
			unless @contract.nil?
				@contract.destroy
			end
			@messages.each do |mess|
				mess.destroy
			end
			@request.destroy
		end
		@contracts = Contract.all
		@contracts.each do |contract|
			if contract.user_id == @user.id
				@request = Request.find_by(id: contract.request_id)
				@request.update_attribute  :state, 0
				contract.destroy
			end
		end
		@user.destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :phonenumber, :password,
	                                     :password_confirmation)
		end

		# Before filters
		
		# Confirms the correct user.
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		# Confirms an admin user.
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end