class CreateInstantSeatAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :instant_seat_assignments do |t|
      t.references :instant_game_entry, null: false, index: { unique: true }, foreign_key: true
      t.references :seat,              null: false, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
