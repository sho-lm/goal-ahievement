class ChangeColumnTimeToWorkRecords < ActiveRecord::Migration[6.0]
  def change
    change_column :work_records, :start_time, :string
    change_column :work_records, :end_time, :string
  end
end
