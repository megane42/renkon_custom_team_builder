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

SheetDefinition.find_or_create_by(name: "tank_a",    role_definition: role_definition_tank)
SheetDefinition.find_or_create_by(name: "tank_b",    role_definition: role_definition_tank)
SheetDefinition.find_or_create_by(name: "damage_a",  role_definition: role_definition_damage)
SheetDefinition.find_or_create_by(name: "damage_b",  role_definition: role_definition_damage)
SheetDefinition.find_or_create_by(name: "support_a", role_definition: role_definition_support)
SheetDefinition.find_or_create_by(name: "support_b", role_definition: role_definition_support)
