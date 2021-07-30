class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :event, null: false, foreign_key: true, index: { unique: false }

      t.timestamps
    end
  end
end
