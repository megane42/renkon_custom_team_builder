class TeamDefinition < ApplicationRecord
  has_many :teams, dependent: :destroy

  enum name: { team_a: "team_a", team_b: "team_b" }

  def self.a_team
    team_a.last
  end

  def self.b_team
    team_b.last
  end
end
