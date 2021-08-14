require "rails_helper"

RSpec.describe SeatDefinition, type: :model do
  describe ".tank_a_seat" do
    it "returns seat_definition of tank_a" do
      expect(described_class.tank_a_seat).to be_a described_class
      expect(described_class.tank_a_seat.name).to eq "tank_a"
    end
  end

  describe ".tank_b_seat" do
    it "returns seat_definition of tank_b" do
      expect(described_class.tank_b_seat).to be_a described_class
      expect(described_class.tank_b_seat.name).to eq "tank_b"
    end
  end

  describe ".damage_a_seat" do
    it "returns seat_definition of damage_a" do
      expect(described_class.damage_a_seat).to be_a described_class
      expect(described_class.damage_a_seat.name).to eq "damage_a"
    end
  end

  describe ".damage_b_seat" do
    it "returns seat_definition of damage_b" do
      expect(described_class.damage_b_seat).to be_a described_class
      expect(described_class.damage_b_seat.name).to eq "damage_b"
    end
  end

  describe ".support_a_seat" do
    it "returns seat_definition of support_a" do
      expect(described_class.support_a_seat).to be_a described_class
      expect(described_class.support_a_seat.name).to eq "support_a"
    end
  end

  describe ".support_b_seat" do
    it "returns seat_definition of support_b" do
      expect(described_class.support_b_seat).to be_a described_class
      expect(described_class.support_b_seat.name).to eq "support_b"
    end
  end
end
