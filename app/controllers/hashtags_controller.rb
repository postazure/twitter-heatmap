class HashtagsController < ApplicationController
  def index
    render json:Hashtag.all
  end
end
