require "rails_helper"

RSpec.describe TeamDefinition, type: :model do
  describe ".a_team" do
    it "returns team_definition of team_a" do
      expect(described_class.a_team).to be_a described_class
      expect(described_class.a_team.name).to eq "team_a"
    end

    it "returns team_definition of team_b" do
      expect(described_class.b_team).to be_a described_class
      expect(described_class.b_team.name).to eq "team_b"
    end
  end
end
