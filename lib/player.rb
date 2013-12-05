require 'scrabble'

class Player

  attr_reader :name, :score, :letters

  def initialize(name)
    @name = name
    @score = 0
    @letters = []
  end

  def plays(word)
    played_letters = word.chars
    @letters.delete(played_letters)
    word_score = Scrabble.score(word)
    @score = @score + word_score
    word_score

  end

  def add_letters(*letters)
    @letters += letters
  end

  def can_play?(word)
    bank = @letters.dup
    word.chars.each do |c|
      return false unless index = bank.index(c)
      bank.slice!(index)
    end
    true
  end
  
end
