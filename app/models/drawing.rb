class Drawing < ApplicationRecord
  belongs_to :event

  belongs_to :giver, class_name: 'Participant', foreign_key: 'giver_id'
  belongs_to :receiver, class_name: 'Participant', foreign_key: 'receiver_id'

  validates :giver_id, presence: true
  validates :receiver_id, presence: true
  validates :event_id, presence: true
  validates :giver_id, uniqueness: { scope: :event_id }
  validates :receiver_id, uniqueness: { scope: :event_id }


end
