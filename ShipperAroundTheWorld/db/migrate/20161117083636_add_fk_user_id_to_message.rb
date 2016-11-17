class AddFkUserIdToMessage < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :users, foreign_key: true
  end
end
