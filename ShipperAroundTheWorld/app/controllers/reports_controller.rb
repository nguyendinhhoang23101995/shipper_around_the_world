class ReportsController < ApplicationController
	def new
		@report = Report.new
	end

	def create
		@report = Report.new(report_params)
		if @report.save
			@contract = Contract.find_by(id: @report.contract_id)
			@request = Request.find_by(id: @contract.request_id)

			if @report.user_id == @request.user_id
				@bank_account = BankAccount.find_by(bank_account: "AAAA123")
				@bank_account_b = BankAccount.find_by(bank_account: @contract.bank_account_b)

				new_money = @bank_account.money - @contract.price
				@bank_account.update_attributes(money: new_money)

				new_money = @bank_account_b.money + @contract.price
				@bank_account_b.update_attributes(money: new_money)

				@request.update_attribute :state, 2
				@contract.update_attribute :state, 1
				@shipper = User.find_by(id: @contract.user_id)
				
				UserMailer.transaction_successful(@shipper, @contract).deliver_now
			end
			flash[:success] = "Report created!"
			redirect_to :back
		else
			flash[:danger] = @report.errors.full_messages.to_sentence
			redirect_to :back
		end
	end

	private
		def report_params
			params.require(:report).permit(:context, :user_id, :contract_id)
		end
end
