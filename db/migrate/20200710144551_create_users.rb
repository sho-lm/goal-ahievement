class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string        :name
      t.string        :password
      t.string        :password_digest
      t.boolean       :admin
      t.boolean       :private
      t.timestamps
    end
  end
end
