class HashtagsController < ApplicationController
  def index
    tweets = Tweet.all
    hashtags = Hashtag.all

    serialized_tweets = serialize_tweets(tweets)
    serialized_hashtags = serialize_hashtags(hashtags)

    render json:{hashtags: serialized_hashtags, tweets: serialized_tweets}
  end
end
