class RequestsController < ApplicationController
	before_action :correct_user,   only: :destroy
	
	def new 
		@request = Request.new
	end
	
	def create
		@request = current_user.requests.build(request_params)
		if params[:request][:content].length >= 6 && params[:request][:price] != '0'
			if @request.save
				respond_to do |format|
					format.html { redirect_to :back }
					format.json { head :ok }
					format.js   { render :layout => false }
				end
			end
		else
			error_string = ""
			if params[:request][:content].length < 6 
				error_string += "Content's length must great than 6."
			end
			if params[:request][:price] == '0'
				error_string += " Price must great than 0."
			end
			flash[:danger] = error_string
			redirect_to :back
		end
	end

	def destroy
		@request = Request.find(params[:id])
		@user = User.find_by(id: @request.user_id)
		@messages = @request.messages
		@contract = @request.contract
		unless @contract.nil?
			@contract.destroy
		end
		@messages.each do |mess|
			mess.destroy
		end
		if @request.state == 0
			@request.destroy
			flash[:success] = "Post deleted!"
			redirect_to :back
		end
	end

	def index
		@requests = Request.search(params[:origin_id], params[:product_type_id])
		@requests = @requests.paginate(:page => params[:page], :per_page => 5)
		@message = Message.new
	end

	private

		def request_params
			params.require(:request).permit(:content, :price, :origin_id, 
											:product_type_id, :state)
		end
    
		def correct_user
			@request = current_user.requests.find_by(id: params[:id])
			redirect_to root_url if @request.nil?
		end
end