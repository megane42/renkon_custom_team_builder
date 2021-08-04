class RoleDefinition < ApplicationRecord
  has_many :sheet_definitions, dependent: :destroy
  has_many :instant_role_requests, dependent: :destroy
  has_many :instant_entries, through: :instant_role_requests

  enum name: { tank: "tank", damage: "damage", support: "support" }

  def self.tank_role
    tank.last
  end

  def self.damage_role
    damage.last
  end

  def self.support_role
    support.last
  end
end
