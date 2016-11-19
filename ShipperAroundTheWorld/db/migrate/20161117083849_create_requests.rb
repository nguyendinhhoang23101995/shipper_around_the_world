class CreateRequests < ActiveRecord::Migration[5.0]
	def change
		create_table :requests do |t|
			t.integer :price
			t.string :origin
			t.float :weight
			t.integer :state, default: 0
			t.string :content

			t.timestamps
		end
	end
end
