require './00_tree_node.rb'

class KnightPathFinder
  attr_accessor :starting_pos, :visited_poss

  def initialize(starting_pos = [0, 0])
    @starting_pos = PolyTreeNode.new(starting_pos)
    @visited_poss = [starting_pos]
  end

  def self.valid_moves(pos)
    moves = [1, -1, 2, -2].permutation(2).to_a
    moves.reject! { |move| move.first.abs == move.last.abs }
    new_poss = moves.map do |move|
      [pos.first + move.first, pos.last + move.last]
    end
    new_poss.select do |new_pos|
      (0..7).include?(new_pos.first) &&
        (0..7).include?(new_pos.last)
    end
  end

  def build_move_tree
    queue = [starting_pos]
    until queue.empty?
      current_pos = queue.shift
      new_move_poss(current_pos).each do |new_move_pos|
        new_pos = PolyTreeNode.new(new_move_pos)
        new_pos.parent = current_pos
        queue << new_pos
      end
    end
  end

  def new_move_poss(pos)
    new_poss = self.class.valid_moves(pos.value)
    new_poss.reject! { |new_pos| visited_poss.include?(new_pos) }
    visited_poss.concat(new_poss)
    new_poss
  end

  def find_path(end_pos)
    end_node = starting_pos.dfs(end_pos)
    self.class.trace_path_back(end_node)
  end

  def self.trace_path_back(end_node)
    path = []
    current_node = end_node
    until current_node.nil?
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path
  end
end
