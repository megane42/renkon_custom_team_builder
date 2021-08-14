class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.references :team,             null: false, foreign_key: true, index: { unique: false }
      t.references :seat_definition, null: false, foreign_key: true, index: { unique: false }

      t.timestamps
    end
    add_index :seats, [:team_id, :seat_definition_id], unique: true
  end
end
