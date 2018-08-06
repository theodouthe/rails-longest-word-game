require 'net/http'
require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    if params[:word].chars.all? do |letter|
      params[:word].downcase.count(letter) <= params[:letters].split.join("").downcase.count(letter)
      end
      url = URI("https://wagon-dictionary.herokuapp.com/#{params[:word].downcase}")
      res = open(url).read
      result = JSON.parse(res)

      if result["found"]
        count = params[:word].length
        @score = "Congratulations! your score is #{count}."
      else
        @score = "sorry but #{params[:word].upcase} is not an english word"
      end

    else
      # redirect_to new_url
      @score = "sorry but #{params[:word]} can't be built with #{params[:letters].split.join(", ").upcase}"
    end
  end
end

