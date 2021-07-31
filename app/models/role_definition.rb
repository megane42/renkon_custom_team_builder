class RoleDefinition < ApplicationRecord
  has_many :sheet_definitions, dependent: :destroy
  enum name: { tank: "tank", damage: "damage", support: "support" }
end
