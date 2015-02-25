class TweetsController < ApplicationController
  def index
    render json:Tweet.all
  end

  def show
    render json:Tweet.find(params[:id])
  end

  def test
    test = []
    # $twitter.search("#yolo", result_type: "recent").take(10).collect do |tweet|
    #   puts "#"*100
    #   p tweet.methods
    #   puts "#"*100
    #   test << "#{tweet.user.screen_name}: #{tweet.text} - Coords:#{tweet.geo?}"
    # end
    $twitter.reverse_geocode({lat:37.7749300,long:-122.4194200}).take(10).collect do |tweet|
      puts "#"*100
      p tweet.place_type
      puts "#"*100
      test << JSON.parse(tweet.to_json)
    end

    # @testoutput = "This is a test string from controller"
    render json: test
  end
end
