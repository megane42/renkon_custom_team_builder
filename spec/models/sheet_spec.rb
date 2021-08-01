require "rails_helper"

RSpec.describe Sheet, type: :model do
  describe ".create" do
    let(:event){ create(:event) }
    let(:game) { create(:game, event: event) }
    let(:team) { create(:team, :team_a, game: game) }

    it "can not create more than 6 sheets for 1 team" do
      expect(team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "tank_a"))).to be_a Sheet
      expect(team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "tank_b"))).to be_a Sheet
      expect(team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "damage_a"))).to be_a Sheet
      expect(team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "damage_b"))).to be_a Sheet
      expect(team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "support_a"))).to be_a Sheet
      expect(team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "support_b"))).to be_a Sheet

      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "tank_a"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "tank_b"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "damage_a"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "damage_b"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "support_a"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "support_b"))}.to raise_error(ActiveRecord::RecordNotUnique)

      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "tank_c"))}.to raise_error(ActiveRecord::RecordInvalid)
      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "damage_c"))}.to raise_error(ActiveRecord::RecordInvalid)
      expect{team.sheets.create!(sheet_definition: SheetDefinition.find_by(name: "support_c"))}.to raise_error(ActiveRecord::RecordInvalid)

      expect(Sheet.count).to eq 6
    end
  end
end
