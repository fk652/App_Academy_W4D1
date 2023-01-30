require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
   nuetral_node = nil
    node = TicTacToeNode.new(game.board, mark)
    node.children.each do |child|
      
      if child.winning_node?(mark)
        return child.prev_move_pos
      elsif !child.losing_node?(mark)
        nuetral_node = child
        end

    end

    nuetral_node.previous_move_position


  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
