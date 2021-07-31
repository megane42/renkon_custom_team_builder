class CreateSheetDefinitions < ActiveRecord::Migration[6.1]
  def change
    create_table :sheet_definitions do |t|
      t.string     :name,            null: false, index: { unique: true  }
      t.references :role_definition, null: false, index: { unique: false }, foreign_key: true

      t.timestamps
    end
    add_index :sheet_definitions, [:name, :role_definition_id], unique: true
  end
end
