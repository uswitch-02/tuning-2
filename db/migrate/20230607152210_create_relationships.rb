class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :followr_id,        null: false
      t.integer :follow_id,         null: false

      t.timestamps
    end
  end
end
