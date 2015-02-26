class Hashtag < ActiveRecord::Base
  has_many :hashtag_and_tweets
  has_many :tweets, through: :hashtag_and_tweets
end
