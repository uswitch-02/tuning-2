class CreateDiarySentiments < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_sentiments do |t|

      t.timestamps
    end
  end
end
