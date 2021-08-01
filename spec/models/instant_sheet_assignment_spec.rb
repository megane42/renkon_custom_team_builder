require "rails_helper"

RSpec.describe InstantSheetAssignment, type: :model do
  describe ".create" do
    let(:tank_role)        { RoleDefinition.find_by(name: "tank") }
    let(:event)            { create(:event) }
    let(:game)             { create(:game, event: event) }
    let(:team_a)           { create(:team, :team_a, game: game) }
    let(:sheet_tank_a)     { create(:sheet, :tank_a, team: team_a) }
    let(:sheet_tank_b)     { create(:sheet, :tank_b, team: team_a) }
    let!(:instant_entries) { create_list(:instant_entry, 2, event: event, games: [game], requested_roles: [tank_role]) }

    it "can not assign 1 entry to 2 sheets" do
      expect(game.instant_game_entries[0].instant_sheet_assignments.create!(sheet: sheet_tank_a)).to be_a described_class
      expect{game.instant_game_entries[0].instant_sheet_assignments.create!(sheet: sheet_tank_b)}.to raise_error ActiveRecord::RecordNotUnique
    end

    it "can not assign 2 entries to 1 sheet" do
      expect(game.instant_game_entries[0].instant_sheet_assignments.create!(sheet: sheet_tank_a)).to be_a described_class
      expect{game.instant_game_entries[1].instant_sheet_assignments.create!(sheet: sheet_tank_a)}.to raise_error ActiveRecord::RecordNotUnique
    end
  end
end
