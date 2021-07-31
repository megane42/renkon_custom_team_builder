class RoleDefinition < ApplicationRecord
  has_many :sheet_definitions, dependent: :destroy
  has_many :instant_role_requests, dependent: :destroy
  has_many :instant_entries, through: :instant_role_requests

  enum name: { tank: "tank", damage: "damage", support: "support" }
end
