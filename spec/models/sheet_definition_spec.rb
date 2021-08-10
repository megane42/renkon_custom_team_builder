require "rails_helper"

RSpec.describe SheetDefinition, type: :model do
  describe ".tank_a_sheet" do
    it "returns sheet_definition of tank_a" do
      expect(described_class.tank_a_sheet).to be_a described_class
      expect(described_class.tank_a_sheet.name).to eq "tank_a"
    end
  end

  describe ".tank_b_sheet" do
    it "returns sheet_definition of tank_b" do
      expect(described_class.tank_b_sheet).to be_a described_class
      expect(described_class.tank_b_sheet.name).to eq "tank_b"
    end
  end

  describe ".damage_a_sheet" do
    it "returns sheet_definition of damage_a" do
      expect(described_class.damage_a_sheet).to be_a described_class
      expect(described_class.damage_a_sheet.name).to eq "damage_a"
    end
  end

  describe ".damage_b_sheet" do
    it "returns sheet_definition of damage_b" do
      expect(described_class.damage_b_sheet).to be_a described_class
      expect(described_class.damage_b_sheet.name).to eq "damage_b"
    end
  end

  describe ".support_a_sheet" do
    it "returns sheet_definition of support_a" do
      expect(described_class.support_a_sheet).to be_a described_class
      expect(described_class.support_a_sheet.name).to eq "support_a"
    end
  end

  describe ".support_b_sheet" do
    it "returns sheet_definition of support_b" do
      expect(described_class.support_b_sheet).to be_a described_class
      expect(described_class.support_b_sheet.name).to eq "support_b"
    end
  end
end
