class Restriction < ApplicationRecord
  belongs_to :event
  belongs_to :participant
  belongs_to :cannot_give_to, class_name: 'Participant', foreign_key: 'cannot_give_to_id'
end
