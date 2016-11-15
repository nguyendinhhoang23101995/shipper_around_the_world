class AddIncivilityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :incivility, :string
  end
end
