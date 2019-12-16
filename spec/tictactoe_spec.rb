require './tictactoe.rb'

describe Board do
  describe "Board#check_win" do
    it "works for top row" do
      board = Board.new
      board.make_play('X', '1')
      board.make_play('X', '2')
      board.make_play('X', '3')
      expect(board.check_win).to eql(true)
    end
    
    it "works for middle row" do
      board = Board.new
      board.make_play('X', '1')
      board.make_play('X', '2')
      board.make_play('X', '3')
      expect(board.check_win).to eql(true)
    end

    it "works for bottom row" do
      board = Board.new
      board.make_play('X', '1')
      board.make_play('X', '2')
      board.make_play('X', '3')
      expect(board.check_win).to eql(true)
    end
    it "works for left column" do
      board = Board.new
      board.make_play('X', '1')
      board.make_play('X', '4')
      board.make_play('X', '7')
      expect(board.check_win).to eql(true)
    end
    it "works for middle column" do
      board = Board.new
      board.make_play('X', '2')
      board.make_play('X', '5')
      board.make_play('X', '8')
      expect(board.check_win).to eql(true)
    end
    it "works for right column" do
      board = Board.new
      board.make_play('X', '3')
      board.make_play('X', '6')
      board.make_play('X', '9')
      expect(board.check_win).to eql(true)
    end
    it "works for bottom-left-up diagonal" do
      board = Board.new
      board.make_play('X', '7')
      board.make_play('X', '5')
      board.make_play('X', '3')
      expect(board.check_win).to eql(true)
    end
    it "works for top-left-down diagonal" do
      board = Board.new
      board.make_play('X', '1')
      board.make_play('X', '5')
      board.make_play('X', '9')
      expect(board.check_win).to eql(true)
    end
    it "fails when no moves have been made" do
      board = Board.new
      expect(board.check_win).to eql(false)
    end
  end

  describe "Board:validate_move" do
    it "returns true if board space available" do
      board = Board.new
      expect(board.validate_move('1')).to eql(true)
    end

    it "returns false if board space taken" do
      board = Board.new
      board.make_play('X', '1')
      expect(board.validate_move('1')).to eql(false)
    end

    it "returns false if give a space number outside the board range" do
      board = Board.new
      expect(board.validate_move('27')).to eql(false)
    end
  end

  describe "Board#display_board" do
    it "prints the board correctly" do
      board = Board.new
      board.make_play('X', '5')
      puts board.display_board
    end
  end
end

describe Player do
  describe "Player#to_s" do
    it "returns correct description string" do
      player = Player.new('X', 2)
      expect(player.to_s).to eql("Player 2")
    end
  end
end

describe Game do
  describe "Game#playGame" do
    it "exits game loop when board reports a win" do
      board = double('board')

      allow(board).to receive(:check_win) {true}

      g = Game.new(board)
      expect { g.playGame }.to output("Player 2 wins!\n").to_stdout
    end
  end

end


