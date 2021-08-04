require "rails_helper"

RSpec.describe InstantEntryForm, type: :model do
  describe "validations" do
    let(:event) { create(:event) }

    describe "name" do
      context "when name is blank" do
        subject do
          InstantEntryForm.new(name: "", can_tank: true, can_damage: true, can_support: false, event: event)
        end

        it "is invalid" do
          expect(subject).to be_invalid
          expect(subject.errors).to be_added(:name, :blank)
        end
      end

      context "when name is taken for an event" do
        subject do
          InstantEntryForm.new(name: "foo", can_tank: true, can_damage: true, can_support: false, event: event)
        end

        let!(:existing_entry) { event.instant_entries.create(name: "foo") }

        it "is invalid" do
          expect(subject).to be_invalid
          expect(subject.errors).to be_added(:name, :taken)
        end
      end
    end

    describe "can_tank / can_damage / can_support" do
      context "when no role is selected" do
        subject do
          InstantEntryForm.new(name: "foo", can_tank: false, can_damage: false, can_support: false, event: event)
        end

        it "is invalid" do
          expect(subject).to be_invalid
          expect(subject.errors).to be_added(:base, :invalid_role_request)
        end
      end
    end
  end

  describe "#save" do
    let(:event) { create(:event) }

    context "valid case" do
      let(:instant_entry_form) do
        InstantEntryForm.new(name: "foo", can_tank: true, can_damage: true, can_support: false, event: event)
      end

      it "returns true" do
        expect(instant_entry_form.save).to eq true
      end

      it "creates instant_entry and instant_role_request" do
        expect(InstantEntry.count).to eq 0
        expect(InstantRoleRequest.count).to eq 0

        instant_entry_form.save

        expect(InstantEntry.count).to eq 1
        expect(InstantRoleRequest.count).to eq 2

        expect(InstantEntry.last.name).to eq "foo"
        expect(InstantEntry.last.can_play?(RoleDefinition.tank_role)).to eq true
        expect(InstantEntry.last.can_play?(RoleDefinition.damage_role)).to eq true
        expect(InstantEntry.last.can_play?(RoleDefinition.support_role)).to eq false
      end
    end

    context "invalid case" do
      let(:instant_entry_form) do
        InstantEntryForm.new(name: "", can_tank: true, can_damage: true, can_support: false, event: event)
      end

      it "returns false" do
        expect(instant_entry_form.save).to eq false
      end

      it "does not create instant_entry and instant_role_request" do
        expect(InstantEntry.count).to eq 0
        expect(InstantRoleRequest.count).to eq 0

        instant_entry_form.save

        expect(InstantEntry.count).to eq 0
        expect(InstantRoleRequest.count).to eq 0
      end
    end
  end
end
