class HashtagsController < ApplicationController
  def index
    tweets = Tweet.last(500)
    hashtags = Hashtag.last(500)

    tweets = Tweet.find(:all, :order => "id desc", :limit => 500).reverse
    hashtags = Hashtag.find(:all, :order => "id desc", :limit => 500).reverse

    serialized_tweets = serialize_tweets(tweets)
    serialized_hashtags = serialize_hashtags(hashtags)

    render json:{hashtags: serialized_hashtags, tweets: serialized_tweets}
  end
end
