require "rails_helper"

RSpec.describe Seat, type: :model do
  describe ".create" do
    let(:event){ create(:event) }
    let(:game) { create(:game, event: event) }
    let(:team) { create(:team, :team_a, game: game) }

    it "can not create more than 6 seats for 1 team" do
      expect(team.seats.create!(seat_definition: SeatDefinition.find_by(name: "tank_a"))).to be_a Seat
      expect(team.seats.create!(seat_definition: SeatDefinition.find_by(name: "tank_b"))).to be_a Seat
      expect(team.seats.create!(seat_definition: SeatDefinition.find_by(name: "damage_a"))).to be_a Seat
      expect(team.seats.create!(seat_definition: SeatDefinition.find_by(name: "damage_b"))).to be_a Seat
      expect(team.seats.create!(seat_definition: SeatDefinition.find_by(name: "support_a"))).to be_a Seat
      expect(team.seats.create!(seat_definition: SeatDefinition.find_by(name: "support_b"))).to be_a Seat

      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "tank_a"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "tank_b"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "damage_a"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "damage_b"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "support_a"))}.to raise_error(ActiveRecord::RecordNotUnique)
      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "support_b"))}.to raise_error(ActiveRecord::RecordNotUnique)

      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "tank_c"))}.to raise_error(ActiveRecord::RecordInvalid)
      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "damage_c"))}.to raise_error(ActiveRecord::RecordInvalid)
      expect{team.seats.create!(seat_definition: SeatDefinition.find_by(name: "support_c"))}.to raise_error(ActiveRecord::RecordInvalid)

      expect(Seat.count).to eq 6
    end
  end
end
