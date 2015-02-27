class HashtagsController < ApplicationController
  def index
    tweets = Tweet.last(300)
    hashtags = Hashtag.last(300)

    serialized_tweets = serialize_tweets(tweets)
    serialized_hashtags = serialize_hashtags(hashtags)

    render json:{hashtags: serialized_hashtags, tweets: serialized_tweets}
  end
end
