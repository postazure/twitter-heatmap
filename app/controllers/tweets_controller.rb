class TweetsController < ApplicationController
  def index
    render json:Tweet.all
  end

  def show
    render json:Tweet.find(params[:id])
  end
end
