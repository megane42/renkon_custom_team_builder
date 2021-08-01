class CreateInstantSheetAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :instant_sheet_assignments do |t|
      t.references :instant_game_entry, null: false, index: { unique: true }, foreign_key: true
      t.references :sheet,              null: false, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
