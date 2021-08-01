class InstantGameEntry < ApplicationRecord
  belongs_to :instant_entry
  belongs_to :game

  has_many :instant_sheet_assignments, dependent: :destroy
  has_many :sheet, through: :instant_sheet_assignments

  delegate :can_play?, to: :instant_entry
end
