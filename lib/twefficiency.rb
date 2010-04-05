require 'sinatra/base'
require 'sinatra/ratpack'
require 'helpers'
require 'haml'
require 'twitter'

class Twefficiency < Sinatra::Base
  helpers Sinatra::Ratpack
  helpers Helpers

  get "/" do
    haml :index
  end

  get '/:username' do
    @username = params[:username]
    @tweets = Twitter::Search.new.from(@username).to_a
    @total_chars = @tweets.inject(0) {|sum, tweet| sum += tweet.text.length }
    if @tweets.empty?
      @avg_tweet_length = 0
      @twefficiency = 0
    else
      @avg_tweet_length = @total_chars / @tweets.length unless @tweets.length.zero?
      @twefficiency = @avg_tweet_length / 140.0
    end
    haml :results
  end

  get '/stylesheets/:sheet.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass :"stylesheets/#{params[:sheet]}"
  end
  
end

