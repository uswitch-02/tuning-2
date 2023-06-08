class CreateSentiments < ActiveRecord::Migration[6.1]
  def change
    create_table :sentiments do |t|
      t.integer :name,      null: false

      t.timestamps
    end
  end
end
