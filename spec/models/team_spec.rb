require "rails_helper"

RSpec.describe Team, type: :model do
  describe ".create" do
    let(:event) { create(:event) }
    let(:game)  { create(:game, event: event) }

    it "can not create more than 2 teams for 1 game" do
      expect(game.teams.create!(team_definition: TeamDefinition.find_by(name: "team_a"))).to be_a Team
      expect(game.teams.create!(team_definition: TeamDefinition.find_by(name: "team_b"))).to be_a Team
      expect{game.teams.create!(team_definition: TeamDefinition.find_by(name: "team_a"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{game.teams.create!(team_definition: TeamDefinition.find_by(name: "team_b"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{game.teams.create!(team_definition: TeamDefinition.find_by(name: "team_c"))}.to raise_error(ActiveRecord::RecordInvalid)
      expect(Team.count).to eq 2
    end
  end
end
