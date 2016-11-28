class OriginsController < ApplicationController
	def new
		@origin = Origin.new
	end

	def create
		@origin = Origin.new(origin_params)
		if @origin.save
			flash[:success] = "Origin created!"
			redirect_to :back
		else
			flash[:danger] = @origin.errors.full_messages.to_sentence
			redirect_to :back
		end
	end

	def destroy
		@origin = Origin.find(params[:id])
		@origin.destroy
		redirect_to :back
	end

	private

		def origin_params
			params.require(:origin).permit(:name)
		end
end