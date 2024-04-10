class CreateRestrictions < ActiveRecord::Migration[7.1]
  def change
    create_table :restrictions do |t|
      t.references :event, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true
      t.references :cannot_give_to, null: false, foreign_key: { to_table: :participants }

      t.timestamps
    end
  end
end
