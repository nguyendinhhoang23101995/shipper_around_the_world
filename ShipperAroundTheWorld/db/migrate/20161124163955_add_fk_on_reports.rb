class AddFkOnReports < ActiveRecord::Migration[5.0]
  def change
  	add_reference :reports, :contract, foreign_key: true
  	add_reference :reports, :user, foreign_key: true
  end
end
