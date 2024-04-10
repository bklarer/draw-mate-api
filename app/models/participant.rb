class Participant < ApplicationRecord
  belongs_to :user
  has_many :invites
  has_many :events, through: :invites

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
end

# TODO: may want to verify email through regex and a confirmation email