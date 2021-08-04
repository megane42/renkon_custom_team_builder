class InstantEntryForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :can_tank, :boolean
  attribute :can_damage, :boolean
  attribute :can_support, :boolean
  attribute :event

  validates :name, presence: true
  validate :name_uniqueness_for_event
  validate :request_at_least_one_role

  def initialize(args = {})
    super
    @instant_entry = InstantEntry.new(event: event, name: name)
    @instant_entry.requested_roles.push(RoleDefinition.tank_role)    if can_tank
    @instant_entry.requested_roles.push(RoleDefinition.damage_role)  if can_damage
    @instant_entry.requested_roles.push(RoleDefinition.support_role) if can_support
  end

  def save
    return false unless valid?
    @instant_entry.save
  end

  def to_model
    @instant_entry
  end

  private

  def request_at_least_one_role
    unless can_tank || can_damage || can_support
      errors.add(:base, :invalid_role_request)
    end
  end

  def name_uniqueness_for_event
    if event.instant_entries.where(name: name).present?
      errors.add(:name, :taken)
    end
  end
end
