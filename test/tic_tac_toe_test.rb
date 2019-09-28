require './test/test_helper'

class TicTacToeTest < MiniTest::Test

  def setup
    @board = Board.new

    @player_x = Player.new("Player 1", :x, @board)
    @player_o = Player.new("Player 2(AI)", :o, @board)

    @current_player = @player_x
    @ttt = TicTacToe.new
  end

  def test_it_exists
    assert_instance_of TicTacToe, @ttt
  end

  def test_it_can_play_a_round
    @board.render
    @current_player = @player_x
    assert_equal @current_player.get_coordinates, "Player 1(x), enter your coordinates in the form x,y:"
    @current_player = @player_o
    assert_equal @current_player.get_coordinates, "Player AI(o), enter your coordinates in the form x,y:"
  end

  def test_it_can_check_if_game_is_over
   @ttt.stub :check_victory, 1 do
     true
     assert @ttt.check_game_over
   end
  end

  def test_it_checks_for_victory
    assert_equal @ttt.check_victory, "Congratulations #{@current_player.name}, you win!"
  end

  def test_it_checks_for_draw
    assert_equal @ttt.check_victory, "Bummer, you've drawn..." || "you win!"
  end

  def test_it_can_switch_players
    assert_equal @current_player, @player_x
    @current_player = @player_o
    assert_equal @current_player, @player_o
  end
end
