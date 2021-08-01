class InstantSheetAssignment < ApplicationRecord
  belongs_to :instant_game_entry
  belongs_to :sheet

  validate :role_correctness

  private

  def role_correctness
    unless instant_game_entry.can_play?(sheet.role_definition)
      errors.add(:sheet, :invalid)
    end
  end
end
