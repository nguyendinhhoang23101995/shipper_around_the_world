class AddPhonenumberToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phonenumber, :string
  end
end
