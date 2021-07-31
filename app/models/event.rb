class Event < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :instant_entries, dependent: :destroy
end
