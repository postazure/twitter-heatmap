class CreateHashtagAndTweets < ActiveRecord::Migration
  def change
    create_table :hashtag_and_tweets do |t|
      t.integer :hashtag_id
      t.integer :tweet_id

      t.timestamps
    end
  end
end
