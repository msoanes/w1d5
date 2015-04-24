require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    move_node = node.children.find { |child| child.winning_node?(mark) }
    if move_node.nil?
      move_node = node.children.find { |child| !child.losing_node?(mark) }
    end
    raise "Whoops" if move_node.nil?
    move_node.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  print "Enter your name: "
  name = gets.chomp
  hp = SuperComputerPlayer.new
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
