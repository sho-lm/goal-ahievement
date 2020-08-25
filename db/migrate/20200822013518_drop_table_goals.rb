class DropTableGoals < ActiveRecord::Migration[6.0]
  def change
    drop_table :goals
  end
end
