class InstantEntry < ApplicationRecord
  belongs_to :event
  has_many :instant_role_requests, dependent: :destroy
  has_many :requested_roles, through: :instant_role_requests, source: :role_definition
end
