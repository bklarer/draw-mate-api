class CreateDrawings < ActiveRecord::Migration[7.1]
  def change
    create_table :drawings do |t|
      t.integer :giver_id
      t.integer :receiver_id
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
