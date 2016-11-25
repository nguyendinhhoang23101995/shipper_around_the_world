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
				@request.update_attribute :state, 2
				@contract.update_attribute :state, 1
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
			params.require(:report).permit(:context,:user_id,:contract_id)
		end
end
