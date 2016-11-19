class Request < ApplicationRecord
	belongs_to :user
	has_one :contract
	validates :user_id, presence: true
	validates_numericality_of :price, presence: true, :greater_than => 0, :less_than => 50000
	validates :content, length: {minimum: 6}
	default_scope -> { order(created_at: :desc) }
end