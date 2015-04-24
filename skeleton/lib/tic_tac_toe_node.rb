require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    if @children.nil?
      children_array = []

      positions.each do |position|
        next unless board[position].nil?
        new_board = board.dup
        new_board[position] = next_mover_mark
        children_array << TicTacToeNode.new(new_board, other_mover_mark, position)
      end

      @children = children_array
    else
      @children
    end
  end

  def losing_node?(evaluator)
    return board.winner == other_mover_mark(evaluator) if board.over?

    if next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return board.winner == evaluator if board.over?

    if next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  def other_mover_mark(mark = next_mover_mark)
    mark == :x ? :o : :x
  end

  def positions
    ([0, 1, 2] * 2).permutation(2).to_a.uniq
  end
end
