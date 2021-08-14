class InstantSeatAssignment < ApplicationRecord
  belongs_to :instant_game_entry
  belongs_to :seat

  validate :role_correctness

  private

  def role_correctness
    unless instant_game_entry.can_play?(seat.role_definition)
      errors.add(:seat, :invalid)
    end
  end
end
