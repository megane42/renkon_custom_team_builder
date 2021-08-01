FactoryBot.define do
  factory :sheet do
    trait :tank_a do
      sheet_definition { SheetDefinition.find_by(name: "tank_a") }
    end
    trait :tank_b do
      sheet_definition { SheetDefinition.find_by(name: "tank_b") }
    end
    trait :damage_a do
      sheet_definition { SheetDefinition.find_by(name: "damage_a") }
    end
    trait :damage_b do
      sheet_definition { SheetDefinition.find_by(name: "damage_b") }
    end
    trait :support_a do
      sheet_definition { SheetDefinition.find_by(name: "support_a") }
    end
    trait :support_b do
      sheet_definition { SheetDefinition.find_by(name: "support_b") }
    end
  end
end
