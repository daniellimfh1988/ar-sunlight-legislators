require_relative '../config'

class CreateCongressMembers < ActiveRecord::Migration
  def change
    create_table :senators do |t|
      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :name_suffix
      t.string :nickname
      t.string :party, :limit => 1
      t.string :state, :limit => 2
      t.string :district
      t.string :in_office
      t.string :gender, :limit => 1
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :crp_id
      t.string :twitter_id
      t.string :congresspedia_url
      t.string :youtube_url
      t.string :facebook_id
      t.string :official_rss
      t.string :senate_class
      t.date :birthdate
      t.timestamp
    end
  end
end