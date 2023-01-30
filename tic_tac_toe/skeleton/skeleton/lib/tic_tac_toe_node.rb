require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :prev_move_pos, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark # either X or O
    @prev_move_pos = prev_move_pos #the last chosen spot on the board, from previous players turn
  end

  def losing_node?(mark) 
    if mark == @next_mover_mark #its the opponents turn if mark == next movers mark
      children.any?{|child| child.board.winner != next_mover_mark || child.board.winner == nil}
    end#its current_players turn 



    
  end

  def winning_node?(mark)
  end

  # This method generates an array of all moves that can be made after
  # the current move.

  def get_moves 
    moves = []

    (0...3).each do |row|
      (0...3).each do |col|
        position = [row, col]
        elem = board[position]
        moves << position if elem == nil
      end
    end
      moves
  end

  def children
    moves = get_moves  
    
    children = []
    moves.each do |move|
      new_board = board.dup
      new_board[move] = next_mover_mark
      next_mark = change_mark
      children << TicTacToeNode.new(new_board, next_mark, move)
    end
    children
  end

  def change_mark
    return :x if @next_mover_mark == :o
    :o
  end


end
