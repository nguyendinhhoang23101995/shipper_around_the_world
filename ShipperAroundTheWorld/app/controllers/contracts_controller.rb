class ContractsController < ApplicationController

  	include ActiveModel::Dirty

  	define_attribute_methods :state

	def new
		@contract = Contract.new
		@request = Request.find(params[:request_id])
		@shipper = User.find_by(id: params[:shipper_id])
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
				flash[:danger] = "Bank account can't be blank"
				redirect_to :back
			else
				if @bank_account_a.bank_account == @bank_account.bank_account || 
				   @bank_account_b.bank_account == @bank_account.bank_account
					flash[:danger] = "Bank account doesn't exist"
					redirect_to :back
				else
					new_money = @bank_account_a.money - @contract.price
					if  new_money > 50					
						if @contract.save
							@bank_account_a.update_attributes(money: new_money)
							
							new_money = @bank_account.money + @contract.price
							@bank_account.update_attributes(money: new_money)

							@request.update_attribute  :state, 1
							@shipper = User.find_by(id: @contract.user_id)

							UserMailer.annouce_create_contract(@shipper, @contract).deliver_now
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
		@message = Message.new
		@contract = Contract.find(params[:contract_id])
		@request = Request.find_by(id: @contract.request_id)
		@customer = User.find_by(id: @request.user_id)
		@shipper = User.find_by(id: @contract.user_id)

	end

	def destroy
		@contract = Contract.find_by(id: contract.id)
		@contract.destroy
	end

	def shipper_doesnt_buy_item
		@contract = Contract.find_by(id: params[:contract_id])
		case @contract.state
		when 5
			@contract.update_attributes(state: 7)
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id: @contract.user_id)
		else
			flash[:danger] = "Someone changed contract state"
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id: @contract.user_id)		
		end

	end
	def shipper_already_buy_item
		@contract = Contract.find_by(id: params[:contract_id])
		case @contract.state
		when 5
			@contract.update_attributes(state: 6)
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id:@contract.user_id)
		else
			flash[:danger] = "Someone changed contract state"
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id:@contract.user_id)
		end
	end
	def shipper_confirm_agreement
		@contract = Contract.find_by(id: params[:contract_id])
		case @contract.state
		when 0,6
			@contract.update_attributes(state: 3)
			redirect_to contract_path(current_user, contract_id: @contract.id, shipper_id: @contract.user_id )
		else
			flash[:danger] = "Someone changed contract state"
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id: @contract.user_id)
		end
	end

	def shipper_cancel
		@contract = Contract.find_by(id: params[:contract_id])
		case @contract.state
		when 0,6
			@contract.update_attributes(state: 1)
			redirect_to contract_path(current_user, contract_id: @contract.id, shipper_id: @contract.user_id)
		
		when 9
			@contract.update_attributes(state: 10)
			@bank_account = BankAccount.find_by(bank_account: "AAAA123")
			@bank_account_a = BankAccount.find_by(bank_account: @contract.bank_account_a)
			@bank_account_b = BankAccount.find_by(bank_account: @contract.bank_account_b)

			new_money = @bank_account.money - @contract.price*95/100
			@bank_account.update_attributes(money: new_money)

			new_money = @bank_account_b.money + @contract.price*5/100
			@bank_account_b.update_attributes(money: new_money)

			new_money = @bank_account_a.money + @contract.price*90/100
			@bank_account_a.update_attributes(money: new_money)

			@request = Request.find_by(id: @contract.request_id)
			@request.update_attribute :state, 0

			@shipper = User.find_by(id: @contract.user_id)
			
			UserMailer.transaction_successful(@shipper, @contract).deliver_now

			@comments = ContractComment.find_by_sql("select * from contract_comments where contract_id = #{@contract.id}");
			@comments.each do |e|
				e.destroy
			end

			@messages = Message.find_by_sql("select * from messages where request_id = #{@contract.request_id} and user_id = #{@contract.user_id}")
			@messages.each do |m|
				m.destroy
			end

			@contract.destroy

			redirect_to root_path
		else
			flash[:danger] = "Someone changed contract state"
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id: @contract.user_id)
		end

	end

	def customer_cancel
		@contract = Contract.find_by(id: params[:contract_id])
		case @contract.state
		when 1
			@contract.update_attributes(state: 2)
			@shipper = User.find_by(id: @contract.user_id)
			new_value = @shipper.total_fail_transaction + 1
			@shipper.update_attributes(total_fail_transaction: new_value)

			@bank_account = BankAccount.find_by(bank_account: "AAAA123")
			@bank_account_a = BankAccount.find_by(bank_account: @contract.bank_account_a)

			new_money = @bank_account.money - @contract.price
			@bank_account.update_attributes(money: new_money)


			new_money = @bank_account_a.money + @contract.price
			@bank_account_a.update_attributes(money: new_money)

			@request = Request.find_by(id: @contract.request_id)
			@request.update_attribute :state, 0

			@shipper = User.find_by(id: @contract.user_id)
			
			UserMailer.transaction_successful(@shipper, @contract).deliver_now

			@comments = ContractComment.find_by_sql("select * from contract_comments where contract_id = #{@contract.id}");
			@comments.each do |e|
				e.destroy
			end

			@messages = Message.find_by_sql("select * from messages where request_id = #{@contract.request_id} and user_id = #{@contract.user_id}")
			@messages.each do |m|
				m.destroy
			end

			@contract.destroy

			redirect_to root_path
		when 3
			@contract.update_attributes(state: 11)
			redirect_to root_path
		when 6
			@contract.update_attributes(state: 8)
			@bank_account = BankAccount.find_by(bank_account: "AAAA123")
			@bank_account_b = BankAccount.find_by(bank_account: @contract.bank_account_b)

			new_money = @bank_account.money - @contract.price*95/100
			@bank_account.update_attributes(money: new_money)

			new_money = @bank_account_b.money + @contract.price*95/100
			@bank_account_b.update_attributes(money: new_money)

			@request = Request.find_by(id: @contract.request_id)
			@request.update_attribute :state, 0
			@shipper = User.find_by(id: @contract.user_id)

			UserMailer.transaction_successful(@shipper, @contract).deliver_now

			@comments = ContractComment.find_by_sql("select * from contract_comments where contract_id = #{@contract.id}");
			@comments.each do |e|
				e.destroy
			end

			@messages = Message.find_by_sql("select * from messages where request_id = #{@contract.request_id} and user_id = #{@contract.user_id}")
			@messages.each do |m|
				m.destroy
			end

			@contract.destroy

			redirect_to root_path
		when 7
			@contract.update_attributes(state: 9)
			redirect_to root_path
		else
			flash[:danger] = "Someone changed contract state"
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id: @contract.user_id)
		end
	end

	def customer_confirm_agreement
		@contract = Contract.find_by(id: params[:contract_id])
		case @contract.state
		when 3
			@contract.update_attributes(state: 4)

			@bank_account = BankAccount.find_by(bank_account: "AAAA123")
			@bank_account_b = BankAccount.find_by(bank_account: @contract.bank_account_b)

			new_money = @bank_account.money - @contract.price
			@bank_account.update_attributes(money: new_money)

			new_money = @bank_account_b.money + @contract.price
			@bank_account_b.update_attributes(money: new_money)

			@request = Request.find_by(id: @contract.request_id)
			@request.update_attribute :state, 2

			@shipper = User.find_by(id: @contract.user_id)
			
			UserMailer.transaction_successful(@shipper, @contract).deliver_now
			redirect_to root_path
		else 
			flash[:danger] = "Someone changed contract state"
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id: @contract.user_id)
		end
	end

	def ask_shipper
		@contract = Contract.find_by(id: params[:contract_id])
		case @contract.state 
		when 0,7
			@contract.update_attributes(state: 5)
			redirect_to root_path
		else
			flash[:danger] = "Someone changed contract state"
			redirect_to contract_path(current_user,contract_id: @contract.id,shipper_id: @contract.user_id)
		end
	end
	private

		def contract_params
			params.require(:contract).permit(:price, :content, :deadline, :bank_account_a, 
											:bank_account_b, :user_id, :request_id)
		end
end