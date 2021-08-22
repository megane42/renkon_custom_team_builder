class InstantSeatAssignmentForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :game
  attribute :must_pick_ids

  validate :enough_role_requests

  SHUFFLE_ATTEMPT_LIMIT = 30

  def shuffle
    return false unless valid?

    SHUFFLE_ATTEMPT_LIMIT.times do
      game.destroy_seat_assignments!

      temporary_instant_game_entries = game.instant_game_entries.to_a

      ActiveRecord::Base.transaction do
        sorted_role_popularity.keys.each do |role|
          fixed_instant_game_entries = filter_by_role(temporary_instant_game_entries, role).sample(4)

          fixed_instant_game_entries[0].seat = team_a.seats.for_role(role)[0]
          fixed_instant_game_entries[1].seat = team_a.seats.for_role(role)[1]
          fixed_instant_game_entries[2].seat = team_b.seats.for_role(role)[0]
          fixed_instant_game_entries[3].seat = team_b.seats.for_role(role)[1]
          fixed_instant_game_entries.each(&:save)

          temporary_instant_game_entries -= fixed_instant_game_entries
        end
      end

      return true if satisfy_must_pick
    end

    game.destroy_seat_assignments!
    errors.add(:base, :constraint_too_strong)
    false
  end

  private

  def tank_role
    @tank_role ||= RoleDefinition.tank_role
  end

  def damage_role
    @damage_role ||= RoleDefinition.damage_role
  end

  def support_role
    @support_role ||= RoleDefinition.support_role
  end

  def team_a
    @team_a ||= game.teams[0]
  end

  def team_b
    @team_b ||= game.teams[1]
  end

  def enough_role_requests
    if sorted_role_popularity[tank_role].to_i    < 4 ||
       sorted_role_popularity[damage_role].to_i  < 4 ||
       sorted_role_popularity[support_role].to_i < 4
      errors.add(:base, :role_request_shortage)
    end
  end

  def sorted_role_popularity
    @sorted_role_popularity = game.instant_entries.reduce(Hash.new(0)) do |result, instant_entry|
      result[tank_role] += 1 if instant_entry.can_play?(tank_role)
      result[damage_role] += 1 if instant_entry.can_play?(damage_role)
      result[support_role] += 1 if instant_entry.can_play?(support_role)
      result
    end.sort_by { |_, v| v }.to_h
  end

  def filter_by_role(instant_game_entries, role)
    instant_game_entries.select do |instant_game_entry|
      instant_game_entry.can_play?(role)
    end
  end

  def satisfy_must_pick
    return true if must_pick_ids.blank?

    game.instant_game_entries.where(id: must_pick_ids).all? do |instant_game_entry|
      instant_game_entry.seat.present?
    end
  end

  def log_result
    game.reload

    Rails.logger.info <<~EOS
      ============================================
      team a

      player: #{game.teams[0].seats[0].instant_game_entry.name} -> #{game.teams[0].seats[0].seat_definition.name}
      player: #{game.teams[0].seats[1].instant_game_entry.name} -> #{game.teams[0].seats[1].seat_definition.name}
      player: #{game.teams[0].seats[2].instant_game_entry.name} -> #{game.teams[0].seats[2].seat_definition.name}
      player: #{game.teams[0].seats[3].instant_game_entry.name} -> #{game.teams[0].seats[3].seat_definition.name}
      player: #{game.teams[0].seats[4].instant_game_entry.name} -> #{game.teams[0].seats[4].seat_definition.name}
      player: #{game.teams[0].seats[5].instant_game_entry.name} -> #{game.teams[0].seats[5].seat_definition.name}

      ============================================
      team b

      player: #{game.teams[1].seats[0].instant_game_entry.name} -> #{game.teams[1].seats[0].seat_definition.name}
      player: #{game.teams[1].seats[1].instant_game_entry.name} -> #{game.teams[1].seats[1].seat_definition.name}
      player: #{game.teams[1].seats[2].instant_game_entry.name} -> #{game.teams[1].seats[2].seat_definition.name}
      player: #{game.teams[1].seats[3].instant_game_entry.name} -> #{game.teams[1].seats[3].seat_definition.name}
      player: #{game.teams[1].seats[4].instant_game_entry.name} -> #{game.teams[1].seats[4].seat_definition.name}
      player: #{game.teams[1].seats[5].instant_game_entry.name} -> #{game.teams[1].seats[5].seat_definition.name}
    EOS
  end
end
