class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def serialize_tweets tweets
    serialized_tweets = []

    tweets.each do |tweet|
      tweet_json = {}

      tweet.attributes.each do |attr_name, attr_value|
        tweet_json[attr_name] = attr_value
      end

      hashtags = tweet.hashtags
      hashtag_ids = []
      hashtags.each do |hashtag|
        hashtag_ids << hashtag.id
      end
      tweet_json["hashtags"] = hashtag_ids
      
      serialized_tweets << tweet_json
    end

    return serialized_tweets
  end

  def serialize_hashtags hashtags
    serialized_hashtags = []

    hashtags.each do |hashtag|
      hashtag_json = {}

      hashtag.attributes.each do |attr_name, attr_value|
        hashtag_json[attr_name] = attr_value
      end

      tweets = hashtag.tweets
      tweet_ids = []
      tweets.each do |tweet|
        tweet_ids << tweet.id
      end
      hashtag_json["tweets"] = tweet_ids
      
      serialized_hashtags << hashtag_json
    end

    return serialized_hashtags
  end
end
