class TweetsController < ApplicationController
  def index
    render json:Tweet.all
  end

  def show
    render json:Tweet.find(params[:id])
  end

  def test
    tweets = []
    radius = 5
    lat = 37.7749300
    lng = -122.4194200
    result_count = 100

    $twitter.search("#",{geocode:"#{lat},#{lng},#{radius}mi"}).take(result_count).collect do |tweet| 
      tweets << JSON.parse(tweet.to_json)
    end

    render json: tweets
  end
end
