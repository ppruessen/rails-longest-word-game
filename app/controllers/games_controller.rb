
class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
    @letters_string = @letters.join('')
  end

  def score
    require "json"
    require "open-uri"
    url = "https://wagon-dictionary.herokuapp.com/#{params['word']}"
    word_serialized = URI.open(url).read
    @word = JSON.parse(word_serialized)
    @is_in_grid = check_chars(params['word']) unless @word["found"] == "true"
  end


  def check_chars(attempt)
    letters = params["letters"].split("")
    attempt_array = attempt.upcase.split("")
    attempt_array.all? do |char|
      letters.delete_at(letters.find_index(char)) if letters.include?(char)
    end
  end
end
