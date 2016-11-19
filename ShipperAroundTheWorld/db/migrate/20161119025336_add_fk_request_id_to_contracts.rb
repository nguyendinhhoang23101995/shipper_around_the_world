class AddFkRequestIdToContracts < ActiveRecord::Migration[5.0]
  def change
  	add_reference :contracts, :request, foreign_key: true
  end
end
