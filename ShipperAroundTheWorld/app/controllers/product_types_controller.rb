class ProductTypesController < ApplicationController
	def new
		@product = ProductType.new
	end

	def create
		@product = ProductType.new(product_type_params)
		if @product.save
			flash[:success] = "Product created!"
			redirect_to :back
		else
			flash[:danger] = @product.errors.full_messages.to_sentence
			redirect_to :back
		end
	end

	def destroy
		@product = ProductType.find(params[:id])
		@product.destroy
		redirect_to :back
	end

	private

		def product_type_params
			params.require(:product_type).permit(:name)
		end
end
