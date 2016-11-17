class AddFkReportIdToContract < ActiveRecord::Migration[5.0]
  def change
    add_reference :contracts, :reports, foreign_key: true
  end
end
