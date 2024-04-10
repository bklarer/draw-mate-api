class Event < ApplicationRecord
    belongs_to :user
    has_many :invites
    has_many :participants, through: :invites
    
    validates :name, presence: true
    validates :date, presence: true
    validate :date_cannot_be_in_the_past  

    private

    def date_cannot_be_in_the_past
      errors.add(:date, "can't be in the past") if date.present? && date < Date.today
    end
end
