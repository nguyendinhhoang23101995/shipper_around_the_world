class RequestsController < ApplicationController
	def create
		@request = current_user.requests.build(request_params)
		if @request.save
			flash[:success] = "Request created!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy
	end

	private

    def request_params
		params.require(:request).permit(:content)
    end
end