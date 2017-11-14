class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError unless letter && letter =~ /[a-z]/i
    letter.downcase!
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    true
  end
  
  def word_with_guesses
    return @word.gsub(/./,'-') if @guesses == ''
    @word.gsub(/[^#{@guesses}]/,'-')
  end
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    @word.chars do |char|
      return :play unless @guesses.include?(char)
    end
    :win
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
