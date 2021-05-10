require 'net/http'
require 'json'

class GamesController < ApplicationController
  
  def new
    @letters = ('a'..'z').to_a.shuffle[0,8]
    
  end
  
  def score
    
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    hash = JSON.parse(response)

    if  @word.chars.all? { |letter| @word.count(letter) <= params[:letters].count(letter) }
      if hash["found"]
        @result = "Congratulations, #{@word} is a valid english word"
      else 
        @result = "Sorry, but #{@word} is a valid english word "
      end
    else
      @result = "Sorry, but #{@word} can't be played with the given letters #{array_word}"
    end
  end
end