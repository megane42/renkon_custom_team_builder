class InstantEntriesController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @instant_entry_form = InstantEntryForm.new
  end

  def create
    @event = Event.find(params[:event_id])
    @instant_entry_form = InstantEntryForm.new(instant_entry_form_params)

    if @instant_entry_form.save
      redirect_to @event, notice: "参加登録が完了しました"
    else
      render :new
    end
  end

  private

  def instant_entry_form_params
    params
      .require(:instant_entry)
      .permit(:name, :can_tank, :can_damage, :can_support)
      .merge(event: @event)
  end
end
