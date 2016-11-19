class AddFkReportIdToContract < ActiveRecord::Migration[5.0]
  def change
    add_reference :contracts, :report, foreign_key: true
  end
end
