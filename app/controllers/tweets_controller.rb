class TweetsController < ApplicationController
  def index
    render json:Tweet.all
  end

  def show
    render json:Tweet.find(params[:id])
  end

  def test
    tweets = []
    
    # Search Options
    lat = 37.7749300
    lng = -122.4194200
    radius = 5
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
end
