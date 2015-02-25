class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :hashtag
      t.float :lat
      t.float :lng
      t.string :text
      t.string :username

      t.timestamps
    end
  end
end
