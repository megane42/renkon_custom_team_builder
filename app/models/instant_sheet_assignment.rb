class InstantSheetAssignment < ApplicationRecord
  belongs_to :instant_entry
  belongs_to :sheet
end
