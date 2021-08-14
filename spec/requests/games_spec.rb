require "rails_helper"

RSpec.describe "Games", type: :request do
  let(:event) { create(:event) }

  describe "GET /events/:event_id/games/:id" do
    let(:game) { create(:game, event: event) }

    it "shows game detail" do
      get event_game_path(event, game)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Games Show")
    end
  end

  describe "POST /events/:event_id/games" do
    context "valid case" do
      it "creates a game, teams, and seats" do
        expect(Game.count).to eq 0
        expect(Team.count).to eq 0
        expect(Seat.count).to eq 0

        post event_games_path(event)

        expect(Game.count).to eq 1
        expect(Team.count).to eq 2
        expect(Seat.count).to eq 12
      end

      it "redirect to created game page" do
        post event_games_path(event)
        expect(response).to redirect_to event_game_url(event, Game.last)
        expect(flash[:notice]).to eq "試合の作成に成功しました"
      end
    end

    context "invalid case" do
      before do
        game_form_double = instance_double(GameForm)
        allow(game_form_double).to receive(:save).and_return(false)
        allow(GameForm).to receive(:new).and_return(game_form_double)
      end

      it "does not create a game, teams, and seats" do
        expect(Game.count).to eq 0
        expect(Team.count).to eq 0
        expect(Seat.count).to eq 0

        post event_games_path(event)

        expect(Game.count).to eq 0
        expect(Team.count).to eq 0
        expect(Seat.count).to eq 0
      end

      it "shows event show page again" do
        post event_games_path(event)

        expect(response).to have_http_status(200)
        expect(response.body).to include("Events Show")
      end
    end
  end
end
