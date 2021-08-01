FactoryBot.define do
  factory :event do
    sequence(:name)     { |i| "event_#{i}" }
    sequence(:start_at) { |i| Time.zone.parse("2021/01/01 00:00:00") + i.hours }
  end
end
