require "rails_helper"

RSpec.describe InstantEntry, type: :model do
  describe "#can_play?" do
    let(:requested_role_definition)   { RoleDefinition.first }
    let(:unrequested_role_definition) { RoleDefinition.last }

    let(:event)           { create(:event) }
    let(:instant_entry)   { create(:instant_entry, event: event, requested_roles: [requested_role_definition]) }

    context "passing correct role" do
      it "return true" do
        expect(instant_entry.can_play?(requested_role_definition)).to eq true
      end
    end

    context "passing correct role" do
      it "return false" do
        expect(instant_entry.can_play?(unrequested_role_definition)).to eq false
      end
    end
  end
end
