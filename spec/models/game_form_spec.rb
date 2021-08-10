require "rails_helper"

RSpec.describe GameForm, type: :model do
  let!(:event) { create(:event) }

  describe "save" do
    subject { described_class.new(event: event).save }

    it "creates a game, teams, and sheets" do
      expect(Game.count).to eq 0
      expect(Team.count).to eq 0
      expect(Sheet.count).to eq 0

      subject

      expect(Game.count).to eq 1
      expect(Team.count).to eq 2
      expect(Sheet.count).to eq 12

      expect(Game.last.teams[0].team_definition).to eq TeamDefinition.a_team
      expect(Game.last.teams[1].team_definition).to eq TeamDefinition.b_team

      expect(Game.last.teams[0].sheets[0].sheet_definition).to eq SheetDefinition.tank_a_sheet
      expect(Game.last.teams[0].sheets[1].sheet_definition).to eq SheetDefinition.tank_b_sheet
      expect(Game.last.teams[0].sheets[2].sheet_definition).to eq SheetDefinition.damage_a_sheet
      expect(Game.last.teams[0].sheets[3].sheet_definition).to eq SheetDefinition.damage_b_sheet
      expect(Game.last.teams[0].sheets[4].sheet_definition).to eq SheetDefinition.support_a_sheet
      expect(Game.last.teams[0].sheets[5].sheet_definition).to eq SheetDefinition.support_b_sheet

      expect(Game.last.teams[1].sheets[0].sheet_definition).to eq SheetDefinition.tank_a_sheet
      expect(Game.last.teams[1].sheets[1].sheet_definition).to eq SheetDefinition.tank_b_sheet
      expect(Game.last.teams[1].sheets[2].sheet_definition).to eq SheetDefinition.damage_a_sheet
      expect(Game.last.teams[1].sheets[3].sheet_definition).to eq SheetDefinition.damage_b_sheet
      expect(Game.last.teams[1].sheets[4].sheet_definition).to eq SheetDefinition.support_a_sheet
      expect(Game.last.teams[1].sheets[5].sheet_definition).to eq SheetDefinition.support_b_sheet
    end

    it "returns true" do
      expect(subject).to eq true
    end
  end
end
