class InstantRoleRequest < ApplicationRecord
  belongs_to :instant_entry
  belongs_to :role_definition
end
