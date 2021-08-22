require "rails_helper"

RSpec.describe InstantGameEntry, type: :model do
  describe "destroy_seat_assignment!" do
    let!(:event)              { create(:event) }
    let!(:game)               { create(:game, event: event) }
    let!(:team)               { create(:team, :team_a, game: game) }
    let!(:seat)               { create(:seat, :tank_a, team: team) }
    let!(:instant_entry)      { create(:instant_entry, event: event, requested_roles: [RoleDefinition.tank_role]) }

    context "when instant_seat_assignment exists" do
      let!(:instant_game_entry) { create(:instant_game_entry, game: game, instant_entry: instant_entry, seat: seat) }

      it "destroy instant_seat_assignment" do
        expect(InstantSeatAssignment.count).to eq 1
        instant_game_entry.destroy_seat_assignment!
        expect(InstantSeatAssignment.count).to eq 0
      end
    end

    context "when instant_seat_assignment does not exist" do
      let!(:instant_game_entry) { create(:instant_game_entry, game: game, instant_entry: instant_entry) }

      it "does nothing" do
        expect(InstantSeatAssignment.count).to eq 0
        instant_game_entry.destroy_seat_assignment!
        expect(InstantSeatAssignment.count).to eq 0
      end
    end
  end
end
