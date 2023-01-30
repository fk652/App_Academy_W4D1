require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :prev_move_pos, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []

    (0...3).each do |row|
      (0...3).each do |col|
        position = [row, col]
        elem = board[position]
        moves << position if elem == nil
      end
      # board.each { |sub| sub.each_with_index { |elem, i| moves << [row, i] if elem == nil } }
    end
    
    children = []
    moves.each do |move|
      new_board = board.dup
      new_board[move] = next_mover_mark
      next_mark = get_next_mark
      children << TicTacToeNode.new(new_board, next_mark, move)
    end
    children
  end

  # def board
  #   @board
  # end

  # def prev_mov_pos
  #   @prev_mov_pos
  # end

  # def next_mover_mark
  #   @next_mover_mark
  # end

  def get_next_mark
    return :x if @next_mover_mark == :o
    :o
  end
end
