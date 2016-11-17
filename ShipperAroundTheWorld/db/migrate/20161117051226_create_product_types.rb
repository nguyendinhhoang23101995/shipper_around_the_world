class CreateProductTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :product_types do |t|
      t.string :name
      t.string :note

      t.timestamps
    end
  end
end
