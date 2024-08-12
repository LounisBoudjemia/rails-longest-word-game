require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    guess = params[:guess].to_s
    url = "https://dictionary.lewagon.com/#{guess}"
    file = URI.open(url).read
    doc = JSON.parse(file)
    check = params[:letters]

    if doc['found'] == true
      if guess.chars.all?(check)
        @result = "#{guess} is a valid english word"
      else
        @result = "Sorry but #{guess} can't be built out"
      end
    elsif doc['found'] == false
      @result = "#{guess} does not seem to be a valid english word"
    end
  end
end
