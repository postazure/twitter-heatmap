class RemoveHashtagFromTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :hashtag
  end
end
