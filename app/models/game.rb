class Game < ApplicationRecord
  belongs_to :event
  has_many :teams, dependent: :destroy

  has_many :instant_game_entries, dependent: :destroy
  has_many :instant_entries, through: :instant_game_entries

  def destroy_seat_assignments
    instant_game_entries.each do |instant_game_entry|
      instant_game_entry.destroy_seat_assignment
    end
  end
end
