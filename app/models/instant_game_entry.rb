class InstantGameEntry < ApplicationRecord
  belongs_to :instant_entry
  belongs_to :game

  has_many :instant_seat_assignments, dependent: :destroy
  has_many :seat, through: :instant_seat_assignments

  delegate :can_play?, to: :instant_entry
end
