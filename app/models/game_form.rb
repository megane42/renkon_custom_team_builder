class GameForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :event

  attr_reader :game
  private attr_writer :game

  def save
    self.game = event.games.build

    event.instant_entries.each do |instant_entry|
      game.instant_entries.push(instant_entry)
    end

    team_a = game.teams.build(team_definition: TeamDefinition.a_team)
    team_a.seats.build(seat_definition: SeatDefinition.tank_a_seat)
    team_a.seats.build(seat_definition: SeatDefinition.tank_b_seat)
    team_a.seats.build(seat_definition: SeatDefinition.damage_a_seat)
    team_a.seats.build(seat_definition: SeatDefinition.damage_b_seat)
    team_a.seats.build(seat_definition: SeatDefinition.support_a_seat)
    team_a.seats.build(seat_definition: SeatDefinition.support_b_seat)

    team_b = game.teams.build(team_definition: TeamDefinition.b_team)
    team_b.seats.build(seat_definition: SeatDefinition.tank_a_seat)
    team_b.seats.build(seat_definition: SeatDefinition.tank_b_seat)
    team_b.seats.build(seat_definition: SeatDefinition.damage_a_seat)
    team_b.seats.build(seat_definition: SeatDefinition.damage_b_seat)
    team_b.seats.build(seat_definition: SeatDefinition.support_a_seat)
    team_b.seats.build(seat_definition: SeatDefinition.support_b_seat)

    game.save
  end
end
