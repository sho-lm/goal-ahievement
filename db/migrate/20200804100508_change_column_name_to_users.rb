class ChangeColumnNameToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :auth_token, :token
  end
end
