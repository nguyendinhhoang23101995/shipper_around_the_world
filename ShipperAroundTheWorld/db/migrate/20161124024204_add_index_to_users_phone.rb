class AddIndexToUsersPhone < ActiveRecord::Migration[5.0]
	def change
		add_index :users, :phonenumber, unique: true
	end
end