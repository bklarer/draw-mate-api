class Participant < ApplicationRecord
  belongs_to :user
  has_many :invites
  has_many :events, through: :invites
  has_many :given_drawings, class_name: 'Drawing', foreign_key: 'giver_id'
  has_many :received_drawings, class_name: 'Drawing', foreign_key: 'receiver_id'
  has_many :restrictions, foreign_key: 'participant_id', dependent: :destroy
  has_many :cannot_give_to_participants, through: :restrictions, source: :cannot_give_to

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end

# TODO: may want to verify email through regex and a confirmation email