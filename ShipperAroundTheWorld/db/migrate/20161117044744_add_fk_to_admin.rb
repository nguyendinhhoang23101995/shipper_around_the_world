class AddFkToAdmin < ActiveRecord::Migration[5.0]
	def change
		add_reference :admins, :user, foreign_key: true
	end
end