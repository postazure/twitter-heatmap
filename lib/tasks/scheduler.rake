
desc "collects tweets and saves to database"

task get_tweets: :environment do
  tweets = []

  # Search Options
  lat = 37.7749300
  lng = -122.4194200
  radius = 5 #in miles
  result_count = 200

  # Get All The Tweets
  $twitter.search("#",{geocode:"#{lat},#{lng},#{radius}mi"}).take(result_count).collect do |tweet|
    hashtags = []

    unless tweet.hashtags.empty?
      tweet.hashtags.each do |hashtag|
        hashtags << hashtag["text"]
      end
    end

    tweets.push({
      hashtag: hashtags,
      lat: tweet.geo["coordinates"].first,
      lng: tweet.geo["coordinates"].last,
      text: tweet.text,
      username: tweet.user["screen_name"],
    })
  end

  # Save Tweets
  tweets.each do |tweet|
    new_tweet = Tweet.new({
      lat:      tweet[:lat],
      lng:      tweet[:lng],
      text:     tweet[:text],
      username: tweet[:username]
    })
    if new_tweet.save

      # Save HashTags
      tweet[:hashtag].each do |hashtag|
        existing_hashtag = Hashtag.find_by(text: hashtag)

        if existing_hashtag
          new_count = existing_hashtag.count + 1
          existing_hashtag.update({count: new_count})
        else
          new_hashtag = Hashtag.new({text: hashtag, count: 1})
          new_hashtag.save
        end

        # Save Hashtag <-> Tweet Association
        HashtagAndTweet.create({
          hashtag_id: ( existing_hashtag ? existing_hashtag.id : new_hashtag.id ),
          tweet_id: new_tweet.id
        })

      end
    end
  end
end

