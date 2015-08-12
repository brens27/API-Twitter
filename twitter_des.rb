require "nokogiri"
require "open-uri"

class TwitterScrapper
	def initialize(url)
		@url = url
		@doc = Nokogiri::HTML(open(@url))
	end

	def extract_username
		@profile_name = @doc.search(".ProfileHeaderCard-name > a")
		@profile_name = @profile_name.first.inner_text
		
		puts "Username: #{@profile_name}"

	end

	def extract_tweets
		@tweets = @doc.search(".content .TweetTextSize")
		# @single_tweet = @tweets.first.inner_text
		@single_tweet = @tweets.first(3)
		  	# puts i.inner_text
			# end

		@date = @doc.search(".content .time .tweet-timestamp")
		@date_tweet = @date.first(3)
		# @date_tweet = @date_tweet["title"]

		@retweet = @doc.search(".IconTextContainer .ProfileTweet-actionCountForPresentation")
		# @retweet_num = @retweet.first.inner_text
		@retweet_num = @retweet.first(3)

		@fav = @doc.search(".ProfileTweet-action--favorite .ProfileTweet-actionCount .ProfileTweet-actionCountForPresentation")
		# @fav_num = @fav.first.inner_text 
		@fav_num = @fav.first(3)

		3.times do |i|
			puts "#{@date_tweet[i]['title']}: #{@single_tweet[i].inner_text}  Retweet: #{@retweet_num[i].inner_text}, Favorite:#{@fav_num[i].inner_text}"
			puts

			# @single_tweet[i].inner_text, @date_tweet[i]["title"], @retweet_num[i].inner_text, @fav_num[i].inner_text
			end
	
		# puts "#{@date_tweet}: #{@single_tweet} Retweet: #{@retweet_num} Favorite: #{@fav_num}"
	end

	def extract_stats
		@tweet_s = @doc.search("#page-outer .ProfileNav-list .ProfileNav-stat .ProfileNav-value")
		@stat_tweet = @tweet_s.first.inner_text

		@follow = @doc.search("#page-outer .ProfileNav-item--following .ProfileNav-stat .ProfileNav-value")
		@stat_follow = @follow.first.inner_text

		@follower = @doc.search("#page-outer .ProfileNav-item--followers .ProfileNav-stat .ProfileNav-value")
		@stat_follower = @follower.first.inner_text

		@fav_s = @doc.search("#page-outer .ProfileNav-item--favorites .ProfileNav-stat .ProfileNav-value")
		@stat_fav = @fav_s.inner_text

		puts "Stats:  Tweets: #{@stat_tweet}, Seguiendo: #{@stat_follow}, Seguidores: #{@stat_follower}, Favoritos: #{@stat_fav}"

	end
end

twitter = TwitterScrapper.new("https://twitter.com/CH14_")

twitter.extract_username
puts"----------------"
twitter.extract_stats
puts "---------------"
twitter.extract_tweets