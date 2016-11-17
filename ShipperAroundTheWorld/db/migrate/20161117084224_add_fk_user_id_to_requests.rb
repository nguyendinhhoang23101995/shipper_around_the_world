class AddFkUserIdToRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :users, foreign_key: true
  end
end
