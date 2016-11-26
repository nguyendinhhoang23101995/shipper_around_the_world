class Report < ApplicationRecord
	validates :context, presence: true, length:{minimum: 10}
	validates :user_id,presence: true
	validates :contract_id,presence: true
end