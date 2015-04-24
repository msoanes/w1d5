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
end
