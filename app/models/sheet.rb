class Sheet < ApplicationRecord
  belongs_to :team
  belongs_to :sheet_definition
end
