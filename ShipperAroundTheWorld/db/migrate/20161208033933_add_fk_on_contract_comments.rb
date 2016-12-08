class AddFkOnContractComments < ActiveRecord::Migration[5.0]
  def change
  		add_reference :contract_comments, :contract, foreign_key: true
  		add_reference :contract_comments, :message, foreign_key: true
  end
end
