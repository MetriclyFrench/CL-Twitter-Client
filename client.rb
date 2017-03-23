#!/usr/bin/env ruby

require 'rubygems'
require 'twitter_oauth'

TWITTER_CONSUMER_KEY    = ENV['TWITTER_CONSUMER_KEY']
TWITTER_CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET']
TWITTER_ACCESS_TOKEN    = ENV['TWITTER_ACCESS_TOKEN']
TWITTER_ACCESS_SECRET   = ENV['TWITTER_ACCESS_SECRET']

client = TwitterOAuth::Client.new(
  :consumer_key => TWITTER_CONSUMER_KEY,
  :consumer_secret => TWITTER_CONSUMER_SECRET,
  :token => TWITTER_ACCESS_TOKEN,
  :secret => TWITTER_ACCESS_SECRET)

case ARGV[]
 when "-l"
  timeline = client.home_timeline()
  timeline = timeline.reverse
  timeline.each{ |tweet|
    puts tweet['text'] + " @FROM #{tweet['user']['name']}"
    puts "\n"
  }
 when "-u"
  if ARGV[1].nil?
    puts "Please enter your status:"
    status = STDIN.readline.chomp
    client.update("#{status}")
  else
    client.update("#{ARGV[1]}")
  end
 when "-m"
  mentions = client.mentions()
  mentions = mentions.reverse
  mentions.each{ |tweet|
    puts tweet['text'] + " @FROM #{tweet['user']['name']}"
    puts "\n"
  }
end
