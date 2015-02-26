class Tweet < ActiveRecord::Base
  has_many :hashtag_and_tweets
  has_many :hashtags, through: :hashtag_and_tweets
end
