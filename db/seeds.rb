# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

role_definition_tank    = RoleDefinition.find_or_create_by(name: "tank")
role_definition_damage  = RoleDefinition.find_or_create_by(name: "damage")
role_definition_support = RoleDefinition.find_or_create_by(name: "support")

TeamDefinition.find_or_create_by(name: "team_a")
TeamDefinition.find_or_create_by(name: "team_b")

SeatDefinition.find_or_create_by(name: "tank_a",    role_definition: role_definition_tank)
SeatDefinition.find_or_create_by(name: "tank_b",    role_definition: role_definition_tank)
SeatDefinition.find_or_create_by(name: "damage_a",  role_definition: role_definition_damage)
SeatDefinition.find_or_create_by(name: "damage_b",  role_definition: role_definition_damage)
SeatDefinition.find_or_create_by(name: "support_a", role_definition: role_definition_support)
SeatDefinition.find_or_create_by(name: "support_b", role_definition: role_definition_support)

if Rails.env.development?
  event = Event.find_or_create_by(name: "event_1", start_at: "2021-01-01 00:00:00")

  unless event.instant_entries.present?
    15.times do |i|
      instant_entry = event.instant_entries.create(name: "player_#{i}")
      case i
      when 0..4
        instant_entry.requested_roles << RoleDefinition.tank_role
        instant_entry.requested_roles << RoleDefinition.damage_role
        instant_entry.requested_roles << RoleDefinition.support_role
      when 5..9
        instant_entry.requested_roles << RoleDefinition.damage_role
        instant_entry.requested_roles << RoleDefinition.support_role
      when 10..14
        instant_entry.requested_roles << RoleDefinition.support_role
      end
    end
  end

  unless event.games.present?
    GameForm.new(event: event).save
  end
end
