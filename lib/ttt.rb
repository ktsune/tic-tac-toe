class TicTacToe

  def initialize
    @board = Board.new

    @player_x = Player.new("Player 1", :x, @board)
    @player_o = Player.new("Player 2(AI)", :o, @board)

    @current_player = @player_x
  end

  def main_menu
    initialize
    print "Welcome to TIC-TAC-TOE\n"
    print "Enter p to play. Enter q to quit.\n"
    answer = gets.chomp
    if answer == 'p'
      system "clear"
      play
    else
      print 'okay bye!'
      exit!
    end
  end

  def play
    loop do
      if @player_x == @current_player
        print "=====\n"
        print "Board\n"
        @board.render
        print "=====\n"
        @current_player.get_coordinates
      elsif @player_o == @current_player
        @current_player.computer_move
      end

      break if check_game_over

      switch_players
    end
  end

  def check_game_over
    check_victory || check_draw
  end

  def check_victory
    if @board.winning_combination?(@current_player.piece)
      puts "Congratulations #{@current_player.name}, you win!"
      true
      @board.render
      main_menu
    else
      false
    end
  end

  def check_draw
    if @board.full?
      puts "Bummer, you've drawn..."
      true
      main_menu
    else
      false
    end
  end

  def switch_players
    if @current_player == @player_x
      @current_player = @player_o
    else
      @current_player = @player_x
    end
  end

  class Board
  attr_accessor :board

  def initialize
    @board = Array.new(3){Array.new(3)}
  end

  def render
    puts
    @board.each do |row|
      row.each do |cell|
          cell.nil? ? print("- ") : print(cell.to_s)
      end
      puts
    end
    puts
  end

  def add_piece(coords, piece)
    if piece_location_valid?(coords)
      @board[coords[0]][coords[1]] = piece
      true
    else
      false
    end
  end

  def piece_location_valid?(coords)
    if within_valid_coordinates?(coords) && @piece == :o
      player_coordinates_available?(coords)
    else
      ai_coordinates_available?(coords)
    end
  end

  def within_valid_coordinates?(coords)
    if (0..2).include?(coords[0]) && (0..2).include?(coords[1])
      true
    else
      puts "Piece coordinates are out of bounds."
    end
  end

  def player_coordinates_available?(coords)
    if @board[coords[0]][coords[1]].nil?
      true
    else
      puts "There is already a piece there!"
    end
  end

  def ai_coordinates_available?(coords)
    if @board[coords[0]][coords[1]].nil?
      true
    else
      puts ' '
    end
  end

  def winning_combination?(piece)
    winning_diagonal?(piece)   ||
    winning_horizontal?(piece) ||
    winning_vertical?(piece)
  end

  def winning_diagonal?(piece)
    diagonals.any? do |diag|
      diag.all?{|cell| cell == piece }
    end
  end

  def winning_vertical?(piece)
    verticals.any? do |vert|
      vert.all?{|cell| cell == piece }
    end
  end

  def winning_horizontal?(piece)
    horizontals.any? do |horz|
      horz.all?{|cell| cell == piece }
    end
  end

  def diagonals
    [[ @board[0][0],@board[1][1],@board[2][2] ],[ @board[2][0],@board[1][1],@board[0][2] ]]
  end

  def verticals
    @board
  end

  def horizontals
    horizontals = []
    3.times do |i|
      horizontals << [@board[0][i],@board[1][i],@board[2][i]]
    end
    horizontals
  end

  def full?
    @board.all? do |row|
      row.none?(&:nil?)
    end
  end
end

class Player
  attr_accessor :name, :piece

  def initialize(name = "Player", piece, board)
    raise "Piece must be a Symbol!" unless piece.is_a?(Symbol)
    @name = name
    @piece = piece
    @board = board
  end

  def computer_move
    possible_coords = [[0,0], [0,1], [0,2], [1,0], [1,1], [1,2], [2,0], [2,1], [2,2]]

    loop do
    coords = possible_coords.sample(1)[0]
      if validate_coordinates_format(coords)
          if @board.add_piece(coords, @piece)
            break
          end
        end
      end
    end

    def get_coordinates
      loop do
      coords = ask_for_coordinates
      if validate_coordinates_format(coords)
          if @board.add_piece(coords, @piece)
            break
          end
        end
      end
    end

    def ask_for_coordinates
      puts "\n#{@name}(#{@piece}), please enter your coordinates in the form x,y:"
      gets.strip.split(",").map(&:to_i)
    end

    def validate_coordinates_format(coords)
      if coords.is_a?(Array) && coords.size == 2
          true
      elsif @current_player == @player_x
        puts "Your coordinates are in the improper format!"
      elsif @current_player == @player_o
        @current_player.computer_move
      end
    end
  end
end

t = TicTacToe.new
t.main_menu
