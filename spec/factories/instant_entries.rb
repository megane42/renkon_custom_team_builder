FactoryBot.define do
  factory :instant_entry do
    sequence(:name) { |i| "name_#{i}" }
  end
end
