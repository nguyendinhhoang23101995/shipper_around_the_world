class AddTotalvoteToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :totalvote, :int
  end
end
