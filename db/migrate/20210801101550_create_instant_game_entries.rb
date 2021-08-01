class CreateInstantGameEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :instant_game_entries do |t|
      t.references :instant_entry, null: false, index: { unique: false }, foreign_key: true
      t.references :game,          null: false, index: { unique: false }, foreign_key: true

      t.timestamps
    end
    add_index :instant_game_entries, [:instant_entry_id, :game_id], unique: true
  end
end
