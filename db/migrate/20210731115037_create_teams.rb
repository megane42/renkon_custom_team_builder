class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.references :game,            null: false, foreign_key: true, index: { unique: false }
      t.references :team_definition, null: false, foreign_key: true, index: { unique: false }

      t.timestamps
    end
    add_index :teams, [:game_id, :team_definition_id], unique: true
  end
end
