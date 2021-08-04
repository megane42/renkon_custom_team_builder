require "rails_helper"

RSpec.describe RoleDefinition, type: :model do
  describe ".tank_role" do
    it "returns role_definition of tank" do
      expect(described_class.tank_role).to be_a described_class
      expect(described_class.tank_role.name).to eq "tank"
    end
  end

  describe ".damage_role" do
    it "returns role_definition of damage" do
      expect(described_class.damage_role).to be_a described_class
      expect(described_class.damage_role.name).to eq "damage"
    end
  end

  describe ".support_role" do
    it "returns role_definition of support" do
      expect(described_class.support_role).to be_a described_class
      expect(described_class.support_role.name).to eq "support"
    end
  end
end
