class MessagesController < ApplicationController
	before_action :correct_user,   only: :destroy

	def create
		@message = Message.new(message_params)

		if @message.save
			if(params[:contract_id] != '')
				@contract_mess = ContractComment.new(contract_id: params[:contract_id],
											message_id: @message.id)
				@contract_mess.save
			end
			flash[:success] = "Message Success!"
			redirect_to :back
		else
			flash[:danger] = @message.errors.full_messages.to_sentence
			redirect_to :back
		end
	end

	def destroy
		@contract_messages = ContractComment.all
		@contract_messages.each do |contract_message|
			if contract_message.message_id == @mess.id
				contract_message.destroy
			end
		end
		@mess = Message.find(params[:id])
		@mess.destroy
		flash[:success] = "Message deleted!"
		redirect_to :back
	end

	private
		def message_params
			params.require(:message).permit(:content, :user_id, :request_id, :from)
		end

		def correct_user
			@mess = current_user.messages.find_by(id: params[:id])
			current_user.requests.each do |request| 
				@mess ||= request.messages.find_by(id: params[:id])
			end
			redirect_to root_url if @mess.nil?
		end
end