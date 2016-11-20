class AddFkOriginIdToRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :origin, foreign_key: true
  end
end
