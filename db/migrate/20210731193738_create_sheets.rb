class CreateSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :sheets do |t|
      t.references :team,             null: false, foreign_key: true, index: { unique: false }
      t.references :sheet_definition, null: false, foreign_key: true, index: { unique: false }

      t.timestamps
    end
    add_index :sheets, [:team_id, :sheet_definition_id], unique: true
  end
end
