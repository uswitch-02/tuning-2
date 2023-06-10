class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.integer :customer_id,     null: false
      t.string :title
      t.text :body
      t.integer :creativity
      t.float :emotion_point
      t.boolean :is_draft,        null: false, default: true
      t.timestamps
    end
  end
end
