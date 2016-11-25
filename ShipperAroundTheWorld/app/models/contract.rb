class Contract < ApplicationRecord
	belongs_to :request
	has_many :reports
	validates :content, length: {minimum: 6}
	validates :bank_account_a, presence: true,length: {minimum: 3}
	validates :bank_account_b, presence: true,length: {minimum: 3}
	validates :deadline, presence: true
	validate :deadline_date_cannot_be_in_the_past
	validates :user_id, presence:true
	validates :request_id, presence:true

	def deadline_date_cannot_be_in_the_past
		if deadline.present? && deadline < Date.today
			errors.add(:deadline, "can't be in the past")
		elsif deadline > ( Date.today + 1.year) && deadline.present?
			errors.add(:deadline, "can't longger than 1 year")
		end
	end
end