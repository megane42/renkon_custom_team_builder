class InstantSheetAssignment < ApplicationRecord
  belongs_to :instant_game_entry
  belongs_to :sheet
end
