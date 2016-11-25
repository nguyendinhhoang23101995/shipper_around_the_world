class RequestsController < ApplicationController
	before_action :correct_user,   only: :destroy
	
	def new 
		@request = Request.new
	end
	
	def create
		@request = current_user.requests.build(request_params)
		if @request.state == 0
			if @request.save
				flash[:success] = "Request created!"
				redirect_to user_path(current_user)
			else
				flash[:danger] = @request.errors.full_messages.to_sentence
				redirect_to user_path(current_user)
			end
		elsif @request.state == 6
			if @request.origin_id == 0 && @request.product_type_id != 0
				$requests = Request.find_by_sql("select id from requests where 
													product_type_id = #{@request.product_type_id} 
													order by created_at DESC;")
			elsif @request.product_type_id == 0 && @request.origin_id != 0
				$requests = Request.find_by_sql("select id from requests where 
													origin_id = #{@request.origin_id}
													order by created_at DESC;")
			elsif @request.product_type_id != 0 && @request.origin_id != 0
				$requests = Request.find_by_sql("select id from requests where 
											origin_id = #{@request.origin_id} 
											and product_type_id = #{@request.product_type_id}
											order by created_at DESC;")
			else
				$requests = Request.find_by_sql("select id from requests order by created_at DESC;")
			end
			redirect_to :action => :index
		end
	end

	def destroy
		@request = Request.find(params[:id])
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
		    flash[:success] = "Request deleted"
		    redirect_to request.referrer || root_url
		end
	end

	def index
		@request = Request.new
		@message = Message.new
	end

	private

		def request_params
			params.require(:request).permit(:content, :price, :origin_id, :product_type_id, :state)
		end
    
		def correct_user
			@request = current_user.requests.find_by(id: params[:id])
			redirect_to root_url if @request.nil?
		end
end