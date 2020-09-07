class RemoveColumnCategoryIdToWorkRecords < ActiveRecord::Migration[6.0]
  def change
    remove_column :work_records, :category_id
  end
end
