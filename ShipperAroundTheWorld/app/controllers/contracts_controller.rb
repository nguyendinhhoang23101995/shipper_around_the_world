class ContractsController < ApplicationController

	def new
		@contract = Contract.new
		@request = Request.find(params[:request_id])
	end

	def create
		@contract = Contract.new(contract_params)

		if @contract.save
			@request = Request.find_by(id: @contract.request_id)
			@request.update_attribute  :state, 1

			flash[:success] = "Contract created!"
			redirect_to user_path(current_user)
		else
			flash[:danger] = @contract.errors.full_messages.to_sentence
			redirect_to user_path(current_user)
		end
	end

	private
    def contract_params
		params.require(:contract).permit(:content, :deadline, :bank_account_a, :bank_account_b, :user_id, :request_id)
    end
end
