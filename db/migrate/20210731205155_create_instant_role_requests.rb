class CreateInstantRoleRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :instant_role_requests do |t|
      t.references :instant_entry,   null: false, index: { unique: false }, foreign_key: true
      t.references :role_definition, null: false, index: { unique: false }, foreign_key: true

      t.timestamps
    end
    add_index :instant_role_requests, [:instant_entry_id, :role_definition_id], unique: true,
              name: "index_instant_role_requests_on_entry_id_and_role_id"
  end
end
