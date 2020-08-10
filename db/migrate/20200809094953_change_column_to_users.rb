class ChangeColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :account_id
    add_column :users, :name, :string
  end
end
