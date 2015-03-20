require_relative '../app/models/congressmember'
require_relative '../app/models/rep'
require_relative '../app/models/sen'
require 'twitter'
require_relative '../app/models/tweet'

Sen.create(title: 'Sen')
Rep.create(title: 'Rep')

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XXX"
  config.consumer_secret     = "XXX"
  config.access_token        = "XXX"
  config.access_token_secret = "XXX"
end

puts "Whose tweets do you want to see? Type in their ID: "
input = gets.chomp
  @congress_member = CongressMember.find_by(id: input)
  @sen_twitter_id = @congress_member.twitter_id
  if @sen_twitter_id.empty?
    puts "This congressman has no Twitter!"
  else
    x = client.user_timeline(@sen_twitter_id).take(10)
    x.each_with_index do |tweet, index|
      puts "#{index+1}. #{client.status(tweet).text}"
        Tweet.create(text: tweet.text, unique_tweet_id: tweet.id,
          legislator_id: @congress_member.id)
  end
end

def by_state
  random_state =  CongressMember.find(rand(CongressMember.count + 1)).state
  CongressMember.find_by_sql("SELECT title, firstname, lastname, state, party FROM congress_members WHERE state = '#{random_state}' ORDER BY title DESC, lastname DESC")
end


def by_gender

  case
    when "M"
      male_sen_num = CongressMember.where(gender: 'M', in_office: '1', title: 'Sen').count
      male_rep_num = CongressMember.where(gender: 'M', in_office: '1', title: 'Rep').count
    when "F"
      fem_sen_num = CongressMember.where(gender: 'F', in_office: '1', title: 'Sen').count
      fem_rep_num = CongressMember.where(gender: 'F', in_office: '1', title: 'Rep').count
  end

  total_sen_num = CongressMember.where(in_office: '1', title: 'Sen').count
  total_rep_num = CongressMember.where(in_office: '1', title: 'Rep').count
  percentage = ((male_sen_num/total_sen_num.to_f)*100).round

  puts "Male Senators: #{male_sen_num} ('#{percentage}'%)"
  puts "Male Representatives: #{male_rep_num} ('#{percentage}'%)"

end


def by_active
  state = []
  state_test = CongressMember.group(:state).where(in_office: '1').order("count(*) DESC").count
  state_test.each do |key,value|
    state << key
  end
  state.each do |x|
    active_senators = CongressMember.where(state: x, in_office: '1', title: 'Sen').count
    active_representatives = CongressMember.where(state: x, in_office: '1', title: 'Rep').count
    puts "#{x}: #{active_senators} Senators, #{active_representatives} Representatives"
  end
end


def total_number
     total_senators = CongressMember.where(title: 'Sen').count
     total_representatives = CongressMember.where(title: 'Rep').count
     puts "Senators: #{total_senators}"
     puts "Representatives: #{total_representatives}"
end


def delete_inactive
  delete_inactive_senators = CongressMember.destroy_all(in_office: '0', title: 'Sen')
  delete_inactive_representatives = CongressMember.destroy_all(in_office: '0', title: 'Rep')
end

   active_senators = CongressMember.where(in_office: '1', title: 'Sen').count

  CongressMember.where(in_office: '1', title: 'Sen').group(:state).order("COUNT(*) DESC")
by_active