class TweetsController < ApplicationController
  def index
    tweets = Tweet.all
    hashtags = Hashtag.all

    serialized_tweets = serialize_tweets(tweets)
    serialized_hashtags = serialize_hashtags(hashtags)

    render json:{tweets: serialized_tweets, hashtags: serialized_hashtags}
  end

  def show
    render json:Tweet.find(params[:id])
  end

  def test
    tweets = []
    
    # Search Options
    lat = 37.7749300
    lng = -122.4194200
    radius = 5 #in miles
    result_count = 10

    $twitter.search("#",{geocode:"#{lat},#{lng},#{radius}mi"}).take(result_count).collect do |tweet| 
      hashtags = []
      hashtags << extract_hashtags(tweet.hashtags) unless tweet.hashtags.empty?

      tweets.push({
        hashtag: hashtags,
        lat: tweet.geo["coordinates"].first,
        lng: tweet.geo["coordinates"].last,
        text: tweet.text,
        username: tweet.user["screen_name"],
      })
    end
    
    render json: tweets
  end

  private

  def extract_hashtags hashtags
    hashtags_text = []
    hashtags.each do |hashtag|
      hashtags_text << hashtag["text"]
    end
    return hashtags_text
  end

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
