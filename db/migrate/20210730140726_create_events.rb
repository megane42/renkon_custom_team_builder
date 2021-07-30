class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string   :name,     null: false, index: { unique: false }
      t.datetime :start_at, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
