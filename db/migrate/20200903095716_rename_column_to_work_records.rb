class RenameColumnToWorkRecords < ActiveRecord::Migration[6.0]
  def change
    rename_column :work_records, :content, :memo
  end
end
