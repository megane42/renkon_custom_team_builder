class Game < ApplicationRecord
  belongs_to :event
  has_many :teams, dependent: :destroy

  has_many :instant_game_entries, dependent: :destroy
  has_many :instant_entries, through: :instant_game_entries
end
