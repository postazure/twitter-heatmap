class TweetsController < ApplicationController
  def index
    render json:Tweet.all
  end

  def show
    render json:Tweet.find(params[:id])
  end

  def test
    test = []
    $twitter.search("#yolo", result_type: "recent").take(3).collect do |tweet|
      puts "#"*100
      p tweet.class
      puts "#"*100
      test << "#{tweet.user.screen_name}: #{tweet.text}"
    end

    # @testoutput = "This is a test string from controller"
    @testoutput = test
  end
end
