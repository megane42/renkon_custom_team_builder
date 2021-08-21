class InstantGameEntry < ApplicationRecord
  belongs_to :instant_entry
  belongs_to :game

  has_one :instant_seat_assignment, dependent: :destroy
  has_one :seat, through: :instant_seat_assignment

  delegate :can_play?, to: :instant_entry
end
