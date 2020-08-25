class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string    :content
      t.string    :color
      t.boolean   :is_finished
      t.integer   :user_id
    end
  end
end
