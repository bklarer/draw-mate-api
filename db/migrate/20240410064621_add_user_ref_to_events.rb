class AddUserRefToEvents < ActiveRecord::Migration[7.1]
  def change
    add_index :events, :user_id
    add_foreign_key :events, :users
  end
end
