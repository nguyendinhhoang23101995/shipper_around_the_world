class AddFkTypeIdToRequest < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :product_types, foreign_key: true
  end
end
