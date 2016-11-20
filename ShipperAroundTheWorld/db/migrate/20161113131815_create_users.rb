class CreateUsers < ActiveRecord::Migration[5.0]
	def change
		create_table :users do |t|
			t.string  :name
			t.string  :email
			t.string  :phonenumber
			t.integer :state, default: 0
			t.float   :rank, default: 0
			t.integer :totalvote, default: 0

			t.timestamps
		end
	end
end