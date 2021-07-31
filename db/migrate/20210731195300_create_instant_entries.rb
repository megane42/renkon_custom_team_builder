class CreateInstantEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :instant_entries do |t|
      t.string     :name,  null: false, index: { unique: false }
      t.references :event, null: false, index: { unique: false }, foreign_key: true

      t.timestamps
    end
  end
end
