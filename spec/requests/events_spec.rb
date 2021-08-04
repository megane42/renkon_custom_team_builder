require "rails_helper"

RSpec.describe "Events", type: :request do
  describe "GET /events/" do
    it "shows events list" do
      get events_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Events Index")
    end
  end

  describe "GET /events/:id" do
    let(:event) { create(:event) }
    it "shows event detail" do
      get event_path(event)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Events Show")
    end
  end

  describe "GET /events/new" do
    it "shows new event page" do
      get new_event_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Events New")
    end
  end

  describe "POST /events/" do
    context "valid case" do
      let(:params) do
        {
          "event" => {
            "name" => "foo",
            "start_at(1i)" => "2021",
            "start_at(2i)" => "12",
            "start_at(3i)" => "31",
            "start_at(4i)" => "00",
            "start_at(5i)" => "00"
          }
        }
      end

      it "create new event" do
        expect { post events_path, params: params }.to change { Event.count }.by(1)
      end

      it "redirect to created event page" do
        post events_path, params: params
        expect(response).to redirect_to event_path(Event.last)
        expect(flash[:notice]).to eq "イベントの作成に成功しました"
      end
    end

    context "invalid case" do
      let(:params) do
        {
          "event" => {
            "name" => "",
            "start_at" => "",
          }
        }
      end

      it "does not create new event" do
        expect { post events_path, params: params }.not_to change { Event.count }
      end

      it "shows new event page again" do
        post events_path, params: params
        expect(response).to have_http_status(200)
        expect(response.body).to include("Events New")
      end
    end
  end

  describe "GET /events/:id/edit" do
    let(:event) { create(:event) }
    it "shows event detail" do
      get edit_event_path(event)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Events Edit")
    end
  end

  describe "PUT /events/:id" do
    context "valid case" do
      let(:event) { create(:event, name: "before_changed") }
      let(:params) do
        {
          "id" => event.id,
          "event" => {
            "name" => "after_changed",
            "start_at(1i)" => "2021",
            "start_at(2i)" => "12",
            "start_at(3i)" => "31",
            "start_at(4i)" => "00",
            "start_at(5i)" => "00"
          }
        }
      end

      it "create new event" do
        expect { put event_path(event), params: params }.to change { event.reload.name }
      end

      it "redirect to updated event page" do
        put event_path(event), params: params
        expect(response).to redirect_to event_path(event)
        expect(flash[:notice]).to eq "イベントの修正に成功しました"
      end
    end

    context "invalid case" do
      let(:event) { create(:event, name: "before_changed") }
      let(:params) do
        {
          "id" => event.id,
          "event" => {
            "name" => "",
            "start_at" => "",
          }
        }
      end

      it "does not create new event" do
        expect { put event_path(event), params: params }.not_to change { event.reload.name }
      end

      it "shows edit event page again" do
        put event_path(event), params: params
        expect(response).to have_http_status(200)
        expect(response.body).to include("Events Edit")
      end
    end
  end
end
