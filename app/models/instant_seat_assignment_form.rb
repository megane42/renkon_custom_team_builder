class InstantSeatAssignmentForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :game

  def shuffle
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

    puts <<~EOS
      ============================================
      team a

      player: #{team_a.seats[0].instant_game_entry.name} -> #{team_a.seats[0].seat_definition.name}
      player: #{team_a.seats[1].instant_game_entry.name} -> #{team_a.seats[1].seat_definition.name}
      player: #{team_a.seats[2].instant_game_entry.name} -> #{team_a.seats[2].seat_definition.name}
      player: #{team_a.seats[3].instant_game_entry.name} -> #{team_a.seats[3].seat_definition.name}
      player: #{team_a.seats[4].instant_game_entry.name} -> #{team_a.seats[4].seat_definition.name}
      player: #{team_a.seats[5].instant_game_entry.name} -> #{team_a.seats[5].seat_definition.name}

      ============================================
      team b

      player: #{team_b.seats[0].instant_game_entry.name} -> #{team_b.seats[0].seat_definition.name}
      player: #{team_b.seats[1].instant_game_entry.name} -> #{team_b.seats[1].seat_definition.name}
      player: #{team_b.seats[2].instant_game_entry.name} -> #{team_b.seats[2].seat_definition.name}
      player: #{team_b.seats[3].instant_game_entry.name} -> #{team_b.seats[3].seat_definition.name}
      player: #{team_b.seats[4].instant_game_entry.name} -> #{team_b.seats[4].seat_definition.name}
      player: #{team_b.seats[5].instant_game_entry.name} -> #{team_b.seats[5].seat_definition.name}
    EOS
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

  def sorted_role_popularity
    game.instant_entries.reduce(Hash.new(0)) do |result, instant_entry|
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
end
