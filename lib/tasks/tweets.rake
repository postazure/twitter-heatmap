namespace :tweets do
  desc "remove_tweets: deletes tweets over 6 hrs old"

  task remove_tweets: :environment do 
    hours_old = 6

    destroy_count = 0
    Tweet.where('created_at < ?', hours_old.hours.ago).each do |tweet|
      destroy_count += 1 if tweet.destroy
    end
    puts "[TWEET] Removed #{destroy_count} Tweet records. Tweets in DB #{Tweet.all.count}"
  end

  desc "get_tweets:collects tweets remove_tweets"
  task get_tweets: :environment do
    tweets = []
    new_tweet_count = 0

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
        new_tweet_count += 1

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
    puts "[TWEET] Added #{new_tweet_count} Tweet records. Tweets in DB #{Tweet.all.count}"
  end
end
