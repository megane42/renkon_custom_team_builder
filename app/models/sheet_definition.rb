class SheetDefinition < ApplicationRecord
  belongs_to :role_definition
  has_many :sheets, dependent: :destroy

  enum name: {
         tank_a:    "tank_a",
         tank_b:    "tank_b",
         damage_a:  "damage_a",
         damage_b:  "damage_b",
         support_a: "support_a",
         support_b: "support_b",
       }

  def self.tank_a_sheet
    tank_a.last
  end

  def self.tank_b_sheet
    tank_b.last
  end

  def self.damage_a_sheet
    damage_a.last
  end

  def self.damage_b_sheet
    damage_b.last
  end

  def self.support_a_sheet
    support_a.last
  end

  def self.support_b_sheet
    support_b.last
  end
end
