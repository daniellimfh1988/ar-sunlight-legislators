require 'twitter'

class Tweet < ActiveRecord::Base
  validates :unique_tweet_id, uniqueness: true
end



# def fetch
#   #we are going to lkink to politicians and obtain their tweets

# end
