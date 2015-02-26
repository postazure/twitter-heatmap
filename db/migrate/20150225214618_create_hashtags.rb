class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :text
      t.integer :count

      t.timestamps
    end
  end
end
