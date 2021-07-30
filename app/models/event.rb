class Event < ApplicationRecord
  has_many :games, dependent: :destroy
end
