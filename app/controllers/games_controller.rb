class GamesController < ApplicationController
  def show
    @game = event.games.find(params[:id])
  end

  def create
    game_form = GameForm.new(event: event)

    if game_form.save
      redirect_to event_game_path(event, game_form.game), notice: "試合の作成に成功しました"
    else
      render "events/show"
    end
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end
end
