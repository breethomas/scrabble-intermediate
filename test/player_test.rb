require 'bundler'
Bundler.require
require './lib/player'
require 'minitest/autorun'
require 'minitest/pride'

class PlayerTest < MiniTest::Unit::TestCase

  def setup
    @player = Player.new("Frank")
    @player2 = Player.new("Katrina")
  end

  def test_player_has_name
    assert_equal "Frank", @player.name
  end

  def test_player_plays_word
    assert_equal 8, @player.plays("hello")
    assert_equal 9, @player.plays("home")
  end

  def test_player_score_default_is_zero
    assert_equal 0, @player.score
  end

  def test_player_aggregates_score
    @player.plays("hello")
    @player.plays("home")
    assert_equal 17, @player.score
  end

  def test_player_has_empty_tray_of_letters
    assert_equal [], @player.letters
  end

  def test_player_adds_letters_to_tray
    @player.add_letters('a')
    @player.add_letters('b', 'c')
    assert_equal ['a', 'b', 'c'], @player.letters
  end

  def test_player_can_check_if_word_is_playable
    @player.add_letters('f', 'l', 'i', 'e', 'x', 'j')
    assert_equal true, @player.can_play?("file")
    assert_equal false, @player.can_play?("fly")
  end

  def test_player_can_play_the_same_letter_multiple_times_in_a_single_word
    @player.add_letters('a','a', 'r', 'd', 'v', 'a', 'r', 'k')
    assert_equal true, @player.can_play?("aardvark")
    assert_equal false, @player.can_play?("aaaaa")
  end

  def test_player_plays_letters
    @player.add_letters('u', 'h', 'g', 'j', 'i', 'x')
    @player.plays('hi')
    assert_equal ['u', 'g', 'j', 'x'], @player.letters
  end

  def test_leading_player
    @player.add_letters('a', 'k', 'p', 'i', 'u', 'q', 'y')
    @player2.add_letters('r', 'b', 'c', 'a', 'a', 'o', 't')
    @player.plays("quip")
    @player2.plays("taco")
    assert_equal true, @player.leading?(@player2)
    refute @player2.leading?(@player)
  end
end

