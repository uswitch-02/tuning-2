class CreateDiarySentiments < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_sentiments do |t|
      t.integer :diary_id,         null: false
      t.integer :sentiment_id,     null: false

      t.timestamps
    end
  end
end
