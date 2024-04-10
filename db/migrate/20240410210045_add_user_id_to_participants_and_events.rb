class AddUserIdToParticipantsAndEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :participants, :user, index: true, foreign_key: true
    add_reference :events, :user, index: true, foreign_key: true
  end
end
