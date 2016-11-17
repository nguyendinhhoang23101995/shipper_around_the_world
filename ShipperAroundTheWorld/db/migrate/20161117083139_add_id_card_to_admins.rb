class AddIdCardToAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :id_card, :string
  end
end
