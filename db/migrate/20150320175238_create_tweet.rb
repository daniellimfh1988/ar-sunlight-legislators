require_relative '../config'
require 'twitter'

class CreateTweet < ActiveRecord::Migration

  def change
    create_table :tweets do |t|
      t.string :unique_tweet_id
      t.text :text
      t.string :legislator_id
      t.timestamp null: false
    end
  end
end