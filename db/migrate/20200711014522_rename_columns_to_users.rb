class RenameColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :admin, :is_admin
    rename_column :users, :private, :is_private
  end
end
