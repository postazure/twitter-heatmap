# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tweets = [
  {
    hashtag: "#helloworld",
    text: "This is a test tweet",
    username: "maxx"
  },
  {
    hashtag: "#helloworld",
    text: "Also a test tweet",
    username: "post"
  },
  {
    hashtag: "#techstuff",
    text: "That stuff is stuff, you know?",
    username: "post"
  },
  {
    hashtag: "#apple",
    text: "Apple-Py, Go code!!!",
    username: "theguru"
  },
  {
    hashtag: "#dogs",
    text: "Saw a dog, and another... and another.",
    username: "acat"
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

