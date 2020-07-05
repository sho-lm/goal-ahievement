class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string      :content
      t.date        :limit
      t.boolean     :achievement_flag
      t.integer     :progress
      t.integer     :order_number
      t.integer     :hierarchy
      t.integer     :children_length
      t.integer     :user_id
      t.integer     :parent_id
      t.timestamps
    end
  end
end
