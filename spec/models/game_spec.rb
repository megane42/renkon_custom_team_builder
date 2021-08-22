require "rails_helper"

RSpec.describe Game, type: :model do
  describe "destroy_seat_assignments!" do
    let!(:event)                { create(:event) }
    let!(:game)                 { create(:game, event: event) }
    let!(:team)                 { create(:team, :team_a, game: game) }
    let!(:seat_a)               { create(:seat, :tank_a, team: team) }
    let!(:seat_b)               { create(:seat, :tank_b, team: team) }
    let!(:instant_entry_a)      { create(:instant_entry, event: event, requested_roles: [RoleDefinition.tank_role]) }
    let!(:instant_entry_b)      { create(:instant_entry, event: event, requested_roles: [RoleDefinition.tank_role]) }
    let!(:instant_game_entry_a) { create(:instant_game_entry, game: game, instant_entry: instant_entry_a, seat: seat_a) }
    let!(:instant_game_entry_b) { create(:instant_game_entry, game: game, instant_entry: instant_entry_b, seat: seat_b) }

    it "destroy all instant_seat_assignments" do
      expect(InstantSeatAssignment.count).to eq 2
      game.destroy_seat_assignments!
      expect(InstantSeatAssignment.count).to eq 0
    end
  end
end
