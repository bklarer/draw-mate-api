class DropUsersTable < ActiveRecord::Migration[7.1]
  def change
    remove_reference :events, :user, index: true, foreign_key: true
    drop_table :users
  end
end
