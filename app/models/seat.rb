class Seat < ApplicationRecord
  belongs_to :team
  belongs_to :seat_definition

  has_many :instant_seat_assignments, dependent: :destroy
  has_many :instant_game_entries, through: :instant_seat_assignments

  delegate :role_definition, to: :seat_definition
end
