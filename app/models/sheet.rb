class Sheet < ApplicationRecord
  belongs_to :team
  belongs_to :sheet_definition

  has_many :instant_sheet_assignments, dependent: :destroy
  has_many :instant_entries, through: :instant_sheet_assignments
end
