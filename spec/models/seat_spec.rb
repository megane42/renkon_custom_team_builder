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

  describe ".for_role" do
    let(:event)          { create(:event) }
    let(:game)           { create(:game, event: event) }
    let(:team)           { create(:team, :team_a, game: game) }
    let(:seat_tank_a)    { create(:seat, :tank_a, team: team) }
    let(:seat_tank_b)    { create(:seat, :tank_b, team: team) }
    let(:seat_damage_a)  { create(:seat, :damage_a, team: team) }
    let(:seat_damage_b)  { create(:seat, :damage_b, team: team) }
    let(:seat_support_a) { create(:seat, :support_a, team: team) }
    let(:seat_support_b) { create(:seat, :support_b, team: team) }

    it "select seats for specified role" do
      expect(Seat.for_role(RoleDefinition.tank_role)).to match_array [seat_tank_a, seat_tank_b]
      expect(Seat.for_role(RoleDefinition.damage_role)).to match_array [seat_damage_a, seat_damage_b]
      expect(Seat.for_role(RoleDefinition.support_role)).to match_array [seat_support_a, seat_support_b]
    end
  end
end
