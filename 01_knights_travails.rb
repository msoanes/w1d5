require './00_tree_node.rb'

class KnightPathFinder
  attr_accessor :starting_pos, :visited_poss

  def initialize(starting_pos = [0, 0])
    @starting_pos = PolyTreeNode.new(starting_pos)
    @visited_poss = [starting_pos]
  end

  def self.valid_moves(pos)
    moves = [1,-1,2,-2].permutation(2).to_a
    moves.reject! { |move| move.first.abs == move.last.abs }
    new_poss = moves.map do |move|
      [pos.first + move.first, pos.last + move.last]
    end
    new_poss.select do |new_pos|
      (0..7).include?(new_pos.first) && \
        (0..7).include?(new_pos.last)
    end
  end

  def build_move_tree
  end

  def new_move_poss(pos)
    new_poss = self.class.valid_moves(pos.value)
    new_poss.reject! { |new_pos| visited_poss.include?(new_pos) }
    visited_poss += new_poss
    new_poss
  end
end

# Basic testing

p KnightPathFinder.valid_moves([4,4])

kpf = KnightPathFinder.new([0, 0])
