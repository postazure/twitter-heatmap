class HashtagsController < ApplicationController
  def index
    tweets = Tweet.last(500)
    hashtags = Hashtag.last(500)

    serialized_tweets = serialize_tweets(tweets)
    serialized_hashtags = serialize_hashtags(hashtags)

    render json:{hashtags: serialized_hashtags, tweets: serialized_tweets}
  end
end
