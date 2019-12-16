class Board
  attr_reader :display_board

  BOARD_LAYOUT_TOP = "\u250F" + ("\u2501"*3 + "\u2533")*2 + "\u2501"*3 + "\u2513"
  BOARD_LAYOUT_SPC = ("\u2503" + " "*3)*3 + "\u2503"
  BOARD_LAYOUT_SEP = "\u2523" + ("\u2501"*3 + "\u254B")*2 + "\u2501"*3 + "\u252B"
  BOARD_LAYOUT_BOT = "\u2517" + ("\u2501"*3 + "\u253B")*2 + "\u2501"*3 + "\u251B"

  def initialize
    @plays = "123456789".split('')
    @display_board = 
      "\u250F" + ("\u2501"*3 + "\u2533")*2 + "\u2501"*3 + "\u2513" + "\n" +
      ("\u2503" + " "*3)*3 + "\u2503" + "\n" +
      "\u2503 #{@plays[0]} \u2503 #{@plays[1]} \u2503 #{@plays[2]} \u2503" + "\n" +
      ("\u2503" + " "*3)*3 + "\u2503" + "\n" +
      "\u2523" + ("\u2501"*3 + "\u254B")*2 + "\u2501"*3 + "\u252B" + "\n" +
      ("\u2503" + " "*3)*3 + "\u2503" + "\n" +
      "\u2503 #{@plays[3]} \u2503 #{@plays[4]} \u2503 #{@plays[5]} \u2503" + "\n" +
      ("\u2503" + " "*3)*3 + "\u2503" + "\n" +
      "\u2523" + ("\u2501"*3 + "\u254B")*2 + "\u2501"*3 + "\u252B" + "\n" +
      ("\u2503" + " "*3)*3 + "\u2503" + "\n" +
      "\u2503 #{@plays[6]} \u2503 #{@plays[7]} \u2503 #{@plays[8]} \u2503" + "\n" +
      ("\u2503" + " "*3)*3 + "\u2503" + "\n" +
      "\u2517" + ("\u2501"*3 + "\u253B")*2 + "\u2501"*3 + "\u251B"

  end

  def display_board
    puts "TIC - TAC - TOE"
    puts "(q to quit)"
    puts "- -"*8
    puts BOARD_LAYOUT_TOP
    puts BOARD_LAYOUT_SPC
    puts "\u2503 #{@plays[0]} \u2503 #{@plays[1]} \u2503 #{@plays[2]} \u2503"
    puts BOARD_LAYOUT_SPC
    puts BOARD_LAYOUT_SEP
    puts BOARD_LAYOUT_SPC
    puts "\u2503 #{@plays[3]} \u2503 #{@plays[4]} \u2503 #{@plays[5]} \u2503"
    puts BOARD_LAYOUT_SPC
    puts BOARD_LAYOUT_SEP
    puts BOARD_LAYOUT_SPC
    puts "\u2503 #{@plays[6]} \u2503 #{@plays[7]} \u2503 #{@plays[8]} \u2503"
    puts BOARD_LAYOUT_SPC
    puts BOARD_LAYOUT_BOT
  end

  def make_play(char, pos)
    @plays[@plays.index(pos)] = char
  end

  def validate_move(pos)
    is_open_slot = false
    if pos == 'q'
      exit
    end
    if @plays.any?(pos)
      is_open_slot = !"XO".include?(@plays[pos.to_i-1])
    end
    is_open_slot
  end

  def check_win
    out = []
    out.push(check_row([0,1,2]))
    out.push(check_row([0,4,8]))
    out.push(check_row([0,3,6]))
    out.push(check_row([1,4,7]))
    out.push(check_row([2,5,8]))
    out.push(check_row([2,4,6]))
    out.push(check_row([3,4,5]))
    out.push(check_row([6,7,8]))
    out.any?
  end

  private
  def check_row(row)
    @plays[row[0]] == @plays[row[1]] && @plays[row[0]] == @plays[row[2]]
  end

end

class Game

  def initialize(board = Board.new)
    @board = board
    @p1 = Player.new("X", 1)
    @p2 = Player.new("O", 2)
    @currentPlayer = @p1
    @nextPlayer = @p2
  end

  def turn(player)
    puts @board.display_board
    puts "#{player}'s turn! Enter a number to choose a box: "
    m = gets.chomp
    while !@board.validate_move(m)
      puts "Oops! You have to enter a number you can see, or q to quit"
      m = gets.chomp
    end

    @board.make_play(player.char, m)
    puts @board.display_board
  end

  def playGame
    while !@board.check_win
      turn(@currentPlayer)
      @currentPlayer, @nextPlayer = @nextPlayer, @currentPlayer
    end
    puts "#{@nextPlayer} wins!"
  end
end

class Player
  attr_reader :char

  def initialize(c, n)
    @char = c
    @num = n
  end

  def to_s
    "Player #{@num}"
  end
end


if __FILE__ == 'tictactoe.rb'
  game = Game.new
  game.playGame
end
