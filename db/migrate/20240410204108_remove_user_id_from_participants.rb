class RemoveUserIdFromParticipants < ActiveRecord::Migration[7.1]
  def change
    remove_reference :participants, :user, index: true, foreign_key: true
  end
end
