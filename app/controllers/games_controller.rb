require 'json'
class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @available_letters = params[:available_letters]
    @word.split('').each do |letter|
      if @available_letters.include?(letter.upcase) && english_word?(@word)
        @response = "Congratulations! #{@word.upcase} is a valid English word!"
      elsif @available_letters.include?(letter.upcase)
        @response = "Sorry, but #{@word.upcase} is not an English word!"
      else
        @response = "Sorry, but #{@word.upcase} can't be built out of #{@available_letters}"
      end
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
