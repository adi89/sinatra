
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require  'active_support/all'
require 'yahoofinance'


get "/quotes" do

  if params[:first].nil?
  else
    @first= params[:first].upcase
    @result= YahooFinance::get_quotes(YahooFinance::StandardQuote, @first)[@first].lastTrade
  end
  erb :quotes
end

