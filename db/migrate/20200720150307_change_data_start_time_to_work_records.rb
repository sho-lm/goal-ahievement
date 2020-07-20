class ChangeDataStartTimeToWorkRecords < ActiveRecord::Migration[6.0]
  def change
    change_column :work_records, :start_time, :time
    change_column :work_records, :end_time,   :time
  end
end
