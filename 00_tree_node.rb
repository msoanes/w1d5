class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    parent.children.delete(self) unless parent.nil?
    @parent = new_parent
    parent.children << self unless parent.nil? || parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Node is not a child." unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if value == target_value
    children.each do |child|
      child_search_result = child.dfs(target_value)
      return child_search_result if child_search_result
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end

    nil
  end
end
