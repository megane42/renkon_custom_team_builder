class Sheet < ApplicationRecord
  belongs_to :team
  belongs_to :sheet_definition

  has_many :instant_sheet_assignments, dependent: :destroy
  has_many :instant_game_entries, through: :instant_sheet_assignments

  delegate :role_definition, to: :sheet_definition
end
