require "rails_helper"

RSpec.describe InstantSeatAssignmentForm, type: :model do
  describe "#shuffle" do
    let!(:event) { create(:event) }

    context "valid case" do
      let!(:instant_entries) do
        12.times.map do |i|
          instant_entry = create(:instant_entry, event: event)
          case i
          when 0..3
            instant_entry.requested_roles << RoleDefinition.tank_role
            instant_entry.requested_roles << RoleDefinition.damage_role
            instant_entry.requested_roles << RoleDefinition.support_role
          when 4..7
            instant_entry.requested_roles << RoleDefinition.damage_role
            instant_entry.requested_roles << RoleDefinition.support_role
          when 8..11
            instant_entry.requested_roles << RoleDefinition.support_role
          end
          instant_entry
        end
      end

      let!(:game) do
        game_form = GameForm.new(event: event)
        game_form.save
        game_form.game
      end

      it "assigns instant entry to seat" do
        instant_seat_assignment_form = InstantSeatAssignmentForm.new(game: game)

        expect(InstantSeatAssignment.count).to eq 0
        expect(instant_seat_assignment_form.shuffle).to eq true
        expect(InstantSeatAssignment.count).to eq 12

        expect(game.instant_game_entries[0].seat.role_definition).to eq RoleDefinition.tank_role
        expect(game.instant_game_entries[1].seat.role_definition).to eq RoleDefinition.tank_role
        expect(game.instant_game_entries[2].seat.role_definition).to eq RoleDefinition.tank_role
        expect(game.instant_game_entries[3].seat.role_definition).to eq RoleDefinition.tank_role

        expect(game.instant_game_entries[4].seat.role_definition).to eq RoleDefinition.damage_role
        expect(game.instant_game_entries[5].seat.role_definition).to eq RoleDefinition.damage_role
        expect(game.instant_game_entries[6].seat.role_definition).to eq RoleDefinition.damage_role
        expect(game.instant_game_entries[7].seat.role_definition).to eq RoleDefinition.damage_role

        expect(game.instant_game_entries[8].seat.role_definition).to eq RoleDefinition.support_role
        expect(game.instant_game_entries[9].seat.role_definition).to eq RoleDefinition.support_role
        expect(game.instant_game_entries[10].seat.role_definition).to eq RoleDefinition.support_role
        expect(game.instant_game_entries[11].seat.role_definition).to eq RoleDefinition.support_role
      end

      it "can execute repeatedly" do
        instant_seat_assignment_form = InstantSeatAssignmentForm.new(game: game)

        expect(InstantSeatAssignment.count).to eq 0
        expect(instant_seat_assignment_form.shuffle).to eq true
        expect(InstantSeatAssignment.count).to eq 12
        expect(instant_seat_assignment_form.shuffle).to eq true
        expect(InstantSeatAssignment.count).to eq 12
      end
    end

    context "invalid case" do
      context "when role request is not enough" do
        let!(:instant_entries) do
          12.times.map do |i|
            instant_entry = create(:instant_entry, event: event)
            case i
            when 0 # only one tank player
              instant_entry.requested_roles << RoleDefinition.tank_role
              instant_entry.requested_roles << RoleDefinition.damage_role
              instant_entry.requested_roles << RoleDefinition.support_role
            when 1..7
              instant_entry.requested_roles << RoleDefinition.damage_role
              instant_entry.requested_roles << RoleDefinition.support_role
            when 8..11
              instant_entry.requested_roles << RoleDefinition.support_role
            end
            instant_entry
          end
        end

        let!(:game) do
          game_form = GameForm.new(event: event)
          game_form.save
          game_form.game
        end

        it "does not assign instant entry to seat" do
          instant_seat_assignment_form = InstantSeatAssignmentForm.new(game: game)

          expect(InstantSeatAssignment.count).to eq 0
          expect(instant_seat_assignment_form.shuffle).to eq false
          expect(instant_seat_assignment_form.errors).to be_added(:base, :role_request_shortage)
          expect(InstantSeatAssignment.count).to eq 0
        end
      end

      context "when the team which satisfies contraints is not found" do
        before do
          stub_const("#{described_class.to_s}::SHUFFLE_ATTEMPT_LIMIT", 0)
        end

        let!(:instant_entries) do
          12.times.map do |i|
            instant_entry = create(:instant_entry, event: event)
            case i
            when 0..3
              instant_entry.requested_roles << RoleDefinition.tank_role
              instant_entry.requested_roles << RoleDefinition.damage_role
              instant_entry.requested_roles << RoleDefinition.support_role
            when 4..7
              instant_entry.requested_roles << RoleDefinition.damage_role
              instant_entry.requested_roles << RoleDefinition.support_role
            when 8..11
              instant_entry.requested_roles << RoleDefinition.support_role
            end
            instant_entry
          end
        end

        let!(:game) do
          game_form = GameForm.new(event: event)
          game_form.save
          game_form.game
        end

        it "does not assign instant entry to seat" do
          instant_seat_assignment_form = InstantSeatAssignmentForm.new(game: game)

          expect(InstantSeatAssignment.count).to eq 0
          expect(instant_seat_assignment_form.shuffle).to eq false
          expect(instant_seat_assignment_form.errors).to be_added(:base, :constraint_too_strong)
          expect(InstantSeatAssignment.count).to eq 0
        end
      end
    end
  end
end
