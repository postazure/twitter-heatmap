# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tweets = [
  {
    text: "This is a test tweet",
    username: "maxx"
  },
  {
    text: "Also a test tweet",
    username: "post"
  },
  {
    text: "That stuff is stuff, you know?",
    username: "post"
  },
  {
    text: "Apple-Py, Go code!!!",
    username: "theguru"
  },
  {
    text: "Saw a dog, and another... and another.",
    username: "acat"
  },
]

hashtags = [
  {
    text: "#helloworld",
    count: 2
  },
    {
    text: "#techstuff",
    count: 1
  },
    {
    text: "#apple",
    count: 1
  },
    {
    text: "#dogs",
    count: 1
  },
]

hashtags_and_tweets = [
  {
    hashtag_id: 1,
    tweet_id: 1
  },
  {
    hashtag_id: 1,
    tweet_id: 2
  },
  {
    hashtag_id: 2,
    tweet_id: 3
  },
  {
    hashtag_id: 3,
    tweet_id: 4
  },
  {
    hashtag_id: 4,
    tweet_id: 5
  },
]

tweets.each do |tweet|
  coords = {
    lat: rand(37.771433..37.771453),
    lng: rand(-122.449298..-122.449278)
  }
  hash = tweet.merge(coords)
  Tweet.create(hash)
end

hashtags.each do |hashtag|
  Hashtag.create(hashtag)
end

hashtags_and_tweets.each do |connection|
  HashtagAndTweet.create(connection)
end


