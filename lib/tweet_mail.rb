#tweeter is the tweet mailer.
require 'simplemail'
module TweetMail
  def send(dest,tweets)
    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.server_settings = {
      :address  => "smtp.gmail.com",
      :port  => 587, 
      :domain => 'copypastel.com',
      :user_name  => "tweetmail@yourdomain.com",
      :password  => "tweetmailer",
      :authentication  => :plain
    }
  end
  
  def format_tweets(tweets)
    # Fill this out!
    tweets
  end
end