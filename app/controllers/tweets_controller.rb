class TweetsController < ApplicationController
  def index
    tweets = Tweet.last(300)
    hashtags = tweets.map {|tweet| tweet.hashtags}.flatten

    serialized_tweets = serialize_tweets(tweets)
    serialized_hashtags = serialize_hashtags(hashtags)

    render json:{tweets: serialized_tweets, hashtags: serialized_hashtags}
  end

  def show
    render json:Tweet.find(params[:id])
  end
end
