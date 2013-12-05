require 'scrabble'

class Player

  attr_reader :name, :score, :letters

  def initialize(name)
    @name = name
    @score = 0
    @letters = []
  end

  def plays(word)
    remove_played_letters(word)
    word_score = Scrabble.score(word)
    @score = score + word_score
    word_score
  end

  def remove_played_letters(word)
    bank = letters
    word.chars.each do |c|
      return false unless index = bank.index(c)
      bank.slice!(index)
      bank
    end
  end

  def add_letters(*letters)
    @letters += letters
  end

  def can_play?(word)
    bank = letters.dup
    word.chars.each do |c|
      return false unless index = bank.index(c)
      bank.slice!(index)
    end
    true
  end

  def leading?(player)
    score > player.score
  end
end
