class MessagesController < ApplicationController
	before_action :correct_user,   only: :destroy

	def create
		@message = Message.new(message_params)

		if @message.save
			flash[:success] = "Message success!"
			redirect_to :back
		else
			flash[:danger] = @message.errors.full_messages.to_sentence
			redirect_to :back
		end
	end

	def destroy
		@mess = Message.find(params[:id])
		@mess.destroy
		flash[:success] = "Message deleted!"
		redirect_to :back
	end

	private
		def message_params
			params.require(:message).permit(:content, :user_id, :request_id)
		end

		def correct_user
			@mess = current_user.messages.find_by(id: params[:id])
			current_user.requests.each do |request| 
				@mess ||= request.messages.find_by(id: params[:id])
			end
			redirect_to root_url if @mess.nil?
		end
end