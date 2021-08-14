FactoryBot.define do
  factory :seat do
    trait :tank_a do
      seat_definition { SeatDefinition.find_by(name: "tank_a") }
    end
    trait :tank_b do
      seat_definition { SeatDefinition.find_by(name: "tank_b") }
    end
    trait :damage_a do
      seat_definition { SeatDefinition.find_by(name: "damage_a") }
    end
    trait :damage_b do
      seat_definition { SeatDefinition.find_by(name: "damage_b") }
    end
    trait :support_a do
      seat_definition { SeatDefinition.find_by(name: "support_a") }
    end
    trait :support_b do
      seat_definition { SeatDefinition.find_by(name: "support_b") }
    end
  end
end
