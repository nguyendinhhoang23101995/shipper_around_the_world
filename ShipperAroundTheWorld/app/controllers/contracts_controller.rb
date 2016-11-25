class ContractsController < ApplicationController

	def new
		@contract = Contract.new
		@request = Request.find(params[:request_id])
	end

	def create
		@contract = Contract.new(contract_params)
		@request = Request.find_by(id: @contract.request_id)


		if @contract.bank_account_a == @contract.bank_account_b
			flash[:danger] = "Two bank account can't be the same"
			redirect_to :back
		else
			@bank_account_a = BankAccount.find_by(bank_account: @contract.bank_account_a)
			@bank_account_b = BankAccount.find_by(bank_account: @contract.bank_account_b)
			@bank_account = BankAccount.find_by(bank_account: "AAAA123")
			if @bank_account_a.nil? || @bank_account_b.nil?
				flash[:danger] = "Bank account doesn't exist"
				redirect_to :back
			else
				if @bank_account_a.bank_account == @bank_account.bank_account || @bank_account_b.bank_account == @bank_account.bank_account
					flash[:danger] = "Bank account doesn't exist"
					redirect_to :back
				else
					new_money = @bank_account_a.money - @request.price
					if  new_money > 50					
						if @contract.save
							@bank_account_a.update_attributes(money: new_money)
							
							new_money = @bank_account.money + @request.price
							@bank_account.update_attributes(money: new_money)

							@request.update_attribute  :state, 1

							flash[:success] = "Contract created!"
							redirect_to user_path(current_user)
						else
							flash[:danger] = @contract.errors.full_messages.to_sentence
							redirect_to :back
						end
					else
						flash[:danger] = "You don't have enough money for trade"
						redirect_to :back
					end
				end
			end
		end
	end

	def show
		@contract = Contract.find(params[:contract_id])
		@request = Request.find_by(id: @contract.request_id)
		@owner = User.find_by(id: @request.user_id)
		@customer = User.find(params[:customer_id])

		@shipper_report = Report.find_by(user_id: params[:customer_id],contract_id: params[:contract_id])

		if current_user.id == @request.user_id
			if @shipper_report.nil?
				customer_report = Report.new
			else
				@customer_report = Report.find_by(user_id: @request_id,contract_id: params[:contract_id])
			end
		end
	end

	def destroy
		@contract = Contract.find_by(id: contract.id)
		@reports = @contract.reports
		@reports.each do |report|
			report.destroy
		end
		@contract.destroy
	end

	private

		def contract_params
			params.require(:contract).permit(:content, :deadline, :bank_account_a, :bank_account_b, :user_id, :request_id)
		end
end