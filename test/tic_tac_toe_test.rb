require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/player'
require './lib/tic_tac_toe'
require 'pry'

class TicTacToeTest < MiniTest::Test

  def setup
    @tic_tac_toe = TicTacToe.new
  end

  def test_it_exists
    assert_instance_of TicTacToe, @tic_tac_toe
  end

  def test_it_can_play_a_round

  end

  def test_it_can_check_if_game_is_over

  end

  def test_it_checks_for_victory

  end

  def test_it_checks_for_draw

  end

  def test_it_can_switch_players

  end
end
