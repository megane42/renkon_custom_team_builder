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

  describe "validation" do
    describe "role_correctness" do
      let(:tank_role)   { RoleDefinition.find_by(name: "tank") }
      let(:damage_role) { RoleDefinition.find_by(name: "damage") }

      let(:event)         { create(:event) }
      let(:game)          { create(:game, event: event) }
      let(:team_a)        { create(:team, :team_a, game: game) }
      let(:sheet_tank)    { create(:sheet, :tank_a, team: team_a) }
      let(:sheet_damage)  { create(:sheet, :damage_a, team: team_a) }
      let(:instant_entry) { create(:instant_entry, event: event, games: [game], requested_roles: [tank_role]) }

      let(:instant_game_entry) { instant_entry.instant_game_entries.find_by(game: game) }

      subject { InstantSheetAssignment.new(instant_game_entry: instant_game_entry, sheet: sheet).valid? }

      context "when assign to correct role sheet" do
        let(:sheet) { sheet_tank }
        it { is_expected.to eq true }
      end

      context "when assign to correct role sheet" do
        let(:sheet) { sheet_damage }
        it { is_expected.to eq false }
      end
    end
  end
end
