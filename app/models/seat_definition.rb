class SeatDefinition < ApplicationRecord
  belongs_to :role_definition
  has_many :seats, dependent: :destroy

  enum name: {
         tank_a:    "tank_a",
         tank_b:    "tank_b",
         damage_a:  "damage_a",
         damage_b:  "damage_b",
         support_a: "support_a",
         support_b: "support_b",
       }

  def self.tank_a_seat
    tank_a.last
  end

  def self.tank_b_seat
    tank_b.last
  end

  def self.damage_a_seat
    damage_a.last
  end

  def self.damage_b_seat
    damage_b.last
  end

  def self.support_a_seat
    support_a.last
  end

  def self.support_b_seat
    support_b.last
  end
end
