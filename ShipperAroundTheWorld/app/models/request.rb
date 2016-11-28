class Request < ApplicationRecord
	belongs_to :user
	has_one :contract
	validates :user_id, presence: true
	validates_numericality_of :price, presence: true, :greater_than => 0, :less_than => 50000
	validates :content, length: {minimum: 6}
	default_scope -> { order(created_at: :desc) }
	has_many :messages

	def self.search origin_id, product_type_id
		print origin_id
		print product_type_id
		if origin_id != '0' && product_type_id == '0'
			Request.where("origin_id = ?", "#{origin_id}")
		elsif origin_id == '0' && product_type_id != '0'
			Request.where("product_type_id = ?", "#{product_type_id}")
		elsif ((origin_id == '0' && product_type_id == '0') || (origin_id.nil? && product_type_id.nil?))
			Request.all
		else
			Request.where("product_type_id = ? and origin_id = ?", 
						  "#{product_type_id}", "#{origin_id}")
		end
	end
end