class RemoveIncivilityFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :incivility, :string
  end
end
