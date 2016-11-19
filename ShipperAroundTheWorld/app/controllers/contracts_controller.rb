class ContractsController < ApplicationController

	def new
		@contract = Contract.new
	end

	def create
		@contract = Contract.new(contract_params)

		if @contract.save
			flash[:success] = "Request created!"
			redirect_to user_path(current_user)
		else
			flash[:danger] = @contract.errors.full_messages.to_sentence
			redirect_to user_path(current_user)
		end
	end

	private

    def contract_params
		params.require(:contract).permit(:content, :deadline, :bank_account_a, :bank_account_b, :user_id)
    end
end
