class HashtagsController < ApplicationController
  def index
    hashtags = Hashtag.last(100)
    tweets = hashtags.map {|hashtag| hashtag.tweets}.flatten

    serialized_tweets = serialize_tweets(tweets)
    serialized_hashtags = serialize_hashtags(hashtags)

    render json:{hashtags: serialized_hashtags, tweets: serialized_tweets}
  end
end
