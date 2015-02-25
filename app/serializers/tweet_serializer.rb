class TweetSerializer < ActiveModel::Serializer
  attributes :id, :hashtag, :lat, :lng, :text, :username
end
