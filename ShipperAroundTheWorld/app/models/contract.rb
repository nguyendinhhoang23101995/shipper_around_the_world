class Contract < ApplicationRecord
	has_one :request

	validates :content, length: {minimum: 6}
	validates :bank_account_a, presence: true,length: {minimum: 6}
	validates :bank_account_b, presence: true,length: {minimum: 6}
	validates :deadline, presence: true
	validates :user_id, presence:true
	validates :request_id,presence:true
end
