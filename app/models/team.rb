class Team < ApplicationRecord
  belongs_to :game
  belongs_to :team_definition
  has_many :sheets, dependent: :destroy
end
