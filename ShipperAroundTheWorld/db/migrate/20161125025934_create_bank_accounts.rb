class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
    	t.string :bank_account
    	t.integer :money
      t.timestamps
    end
  end
end
