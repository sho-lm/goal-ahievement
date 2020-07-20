class CreateWorkRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :work_records do |t|
      t.text        :content
      t.date        :worked_on
      t.integer     :worked_for
      t.string      :start_time
      t.string      :end_time
      t.integer     :user_id
      t.integer     :goal_id
      t.integer     :category_id
      t.timestamps
    end
  end
end
