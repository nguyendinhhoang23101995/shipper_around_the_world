class UserMailer < ApplicationMailer
	default :from => 'nhom495itss@gmail.com'

	def account_activation user
		@user = user
		mail to: user.email, subject: "Account activation"
	end

	def password_reset user
		@user = user
		mail to: user.email, subject: "Password reset"
	end

	def annouce_create_contract shipper, customer, contract
		@shipper = shipper
		@customer = customer
		@contract = contract
		mail to: shipper.email, subject: "Contract has been created"
	end

	def transaction_successful user
		@user = user
		mail to: user.email, subject: "Transaction successful"
	end
end