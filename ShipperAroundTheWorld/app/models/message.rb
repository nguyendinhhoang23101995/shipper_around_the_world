class Message < ApplicationRecord
	belongs_to :user
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :context, presence: true, length: { minimum: 6 }
end