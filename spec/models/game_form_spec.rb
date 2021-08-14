require "rails_helper"

RSpec.describe GameForm, type: :model do
  let!(:event) { create(:event) }

  describe "save" do
    subject { described_class.new(event: event).save }

    it "creates a game, teams, and seats" do
      expect(Game.count).to eq 0
      expect(Team.count).to eq 0
      expect(Seat.count).to eq 0

      subject

      expect(Game.count).to eq 1
      expect(Team.count).to eq 2
      expect(Seat.count).to eq 12

      expect(Game.last.teams[0].team_definition).to eq TeamDefinition.a_team
      expect(Game.last.teams[1].team_definition).to eq TeamDefinition.b_team

      expect(Game.last.teams[0].seats[0].seat_definition).to eq SeatDefinition.tank_a_seat
      expect(Game.last.teams[0].seats[1].seat_definition).to eq SeatDefinition.tank_b_seat
      expect(Game.last.teams[0].seats[2].seat_definition).to eq SeatDefinition.damage_a_seat
      expect(Game.last.teams[0].seats[3].seat_definition).to eq SeatDefinition.damage_b_seat
      expect(Game.last.teams[0].seats[4].seat_definition).to eq SeatDefinition.support_a_seat
      expect(Game.last.teams[0].seats[5].seat_definition).to eq SeatDefinition.support_b_seat

      expect(Game.last.teams[1].seats[0].seat_definition).to eq SeatDefinition.tank_a_seat
      expect(Game.last.teams[1].seats[1].seat_definition).to eq SeatDefinition.tank_b_seat
      expect(Game.last.teams[1].seats[2].seat_definition).to eq SeatDefinition.damage_a_seat
      expect(Game.last.teams[1].seats[3].seat_definition).to eq SeatDefinition.damage_b_seat
      expect(Game.last.teams[1].seats[4].seat_definition).to eq SeatDefinition.support_a_seat
      expect(Game.last.teams[1].seats[5].seat_definition).to eq SeatDefinition.support_b_seat
    end

    it "returns true" do
      expect(subject).to eq true
    end
  end
end
