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
end
