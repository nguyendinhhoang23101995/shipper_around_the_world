class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.string :content
      t.date :deadline
      t.string :bank_account_a
      t.string :bank_account_b
      t.integer :state

      t.timestamps
    end
  end
end
