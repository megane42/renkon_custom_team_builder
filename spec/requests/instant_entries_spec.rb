require "rails_helper"

RSpec.describe "Instant Entries", type: :request do
  describe "GET /events/:event_id/instant_entries/new" do
    let(:event) { create(:event) }

    it "shows new instant entry page" do
      get new_event_instant_entry_path(event)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Instant Entries New")
    end
  end

  describe "POST /events/:event_id/instant_entries/" do
    let(:event) { create(:event) }

    context "valid case" do
      let(:params) do
        {
          "instant_entry" => {
            "name" => "foo",
            "can_tank" => "1",
            "can_damage" => "1",
            "can_support" => "0"
          }
        }
      end

      it "creates new instant_entry and instant_role_requests" do
        expect(InstantEntry.count).to eq 0
        expect(InstantRoleRequest.count).to eq 0

        post event_instant_entries_path(event), params: params

        expect(InstantEntry.count).to eq 1
        expect(InstantRoleRequest.count).to eq 2

        expect(InstantEntry.last.name).to eq "foo"
        expect(InstantEntry.last.can_play?(RoleDefinition.tank_role)).to eq true
        expect(InstantEntry.last.can_play?(RoleDefinition.damage_role)).to eq true
        expect(InstantEntry.last.can_play?(RoleDefinition.support_role)).to eq false
      end

      it "redirects to event page" do
        post event_instant_entries_path(event), params: params
        expect(response).to redirect_to event_url(event)
        expect(flash[:notice]).to eq "参加登録が完了しました"
      end
    end

    context "invalid case" do
      let(:params) do
        {
          "instant_entry" => {
            "name" => "",
            "can_tank" => "0",
            "can_damage" => "0",
            "can_support" => "0"
          }
        }
      end

      it "does not create new instant_entry and instant_role_requests" do
        expect(InstantEntry.count).to eq 0
        expect(InstantRoleRequest.count).to eq 0

        post event_instant_entries_path(event), params: params

        expect(InstantEntry.count).to eq 0
        expect(InstantRoleRequest.count).to eq 0
      end

      it "shows new instant entry page again" do
        post event_instant_entries_path(event), params: params
        expect(response).to have_http_status 200
        expect(response.body).to include "Instant Entries New"
      end
    end
  end
end
