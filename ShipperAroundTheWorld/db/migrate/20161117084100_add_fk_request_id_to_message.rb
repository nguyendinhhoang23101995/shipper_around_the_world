class AddFkRequestIdToMessage < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :request, foreign_key: true
  end
end
