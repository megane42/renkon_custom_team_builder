FactoryBot.define do
  factory :team do
    trait :team_a do
      team_definition { TeamDefinition.find_by(name: "team_a") }
    end
    trait :team_b do
      team_definition { TeamDefinition.find_by(name: "team_b") }
    end
  end
end
