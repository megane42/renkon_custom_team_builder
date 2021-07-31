class TeamDefinition < ApplicationRecord
  has_many :teams, dependent: :destroy
  enum name: { team_a: "team_a", team_b: "team_b" }
end
