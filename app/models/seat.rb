class Seat < ApplicationRecord
  belongs_to :team
  belongs_to :seat_definition

  has_one :instant_seat_assignment, dependent: :destroy
  has_one :instant_game_entry, through: :instant_seat_assignment

  delegate :role_definition, to: :seat_definition
end
