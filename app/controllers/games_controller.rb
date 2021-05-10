require 'net/http'
require 'json'

class GamesController < ApplicationController
  
  def new
    @letters = ('a'..'z').to_a.shuffle[0,8]
  end
  
  def score
    @word = params[:word]
    hash = parsing(@word)

    if valid?
      if hash["found"]
        @result = "Congratulations, #{@word} is a valid english word"
        @score = user_score
      else 
        @result = "Sorry, but #{@word} is a valid english word "
        @score = user_score
      end
    else
      @result = "Sorry, but #{@word} can't be played with the given letters #{@word}"
      @score = user_score
    end
  end

  private
  def parsing(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def valid?
    @word.chars.all? { |letter| @word.count(letter) <= params[:letters].count(letter) }
  end

  def user_score
    session[:score] = 0 if session[:score].nil?
    session[:score] += @word.length if valid?
    
    session[:score]
  end
  
end