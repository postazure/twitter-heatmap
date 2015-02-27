class Hashtag < ActiveRecord::Base
  has_many :hashtag_and_tweets, dependent: :destroy
  has_many :tweets, through: :hashtag_and_tweets
end
