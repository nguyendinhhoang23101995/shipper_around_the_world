class AddFkContractIdToRequest < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :contract, foreign_key: true
  end
end
