class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.integer :customer_id,     null: false
      t.string :title,            null: false
      t.text :body,               null: false
      t.integer :creativity,      null: false
      t.float :emotion_point,     null: false
      t.boolean :is_draft,        null: false, default: true
      t.timestamps
    end
  end
end
