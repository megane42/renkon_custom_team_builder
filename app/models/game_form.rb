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
    team_a.sheets.build(sheet_definition: SheetDefinition.tank_a_sheet)
    team_a.sheets.build(sheet_definition: SheetDefinition.tank_b_sheet)
    team_a.sheets.build(sheet_definition: SheetDefinition.damage_a_sheet)
    team_a.sheets.build(sheet_definition: SheetDefinition.damage_b_sheet)
    team_a.sheets.build(sheet_definition: SheetDefinition.support_a_sheet)
    team_a.sheets.build(sheet_definition: SheetDefinition.support_b_sheet)

    team_b = game.teams.build(team_definition: TeamDefinition.b_team)
    team_b.sheets.build(sheet_definition: SheetDefinition.tank_a_sheet)
    team_b.sheets.build(sheet_definition: SheetDefinition.tank_b_sheet)
    team_b.sheets.build(sheet_definition: SheetDefinition.damage_a_sheet)
    team_b.sheets.build(sheet_definition: SheetDefinition.damage_b_sheet)
    team_b.sheets.build(sheet_definition: SheetDefinition.support_a_sheet)
    team_b.sheets.build(sheet_definition: SheetDefinition.support_b_sheet)

    game.save
  end
end
