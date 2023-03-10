require_relative "poly_tree_node"

class KnightPathFinder
  attr_reader :root_node

  def self.valid_moves(position) #[1,2]
    x, y = position
    pos_1 = [(x+2), (y+1)] 
    pos_2 = [(x+2), (y-1)] 
    pos_3 = [(x+1), (y+2)]
    pos_4 = [(x+1), (y-2)]
    pos_5 = [(x-1), (y+2)]
    pos_6 = [(x-1), (y-2)]
    pos_7 = [(x-2), (y+1)]
    pos_8 = [(x-2), (y-1)]
    possible_moves  = [pos_1, pos_3, pos_8, pos_4, pos_5, pos_2, pos_6, pos_8]
    possible_moves.select { |move| position_in_bounds?(move) }
  end

  def self.position_in_bounds?(position)
    x, y = position
    x >= 0 && x <= 7 && y >= 0 && y <= 7
  end

  def initialize(position)  # [1, 2]
    raise "invalid starting position given" if !KnightPathFinder.position_in_bounds?(position)
    @root_node = PolyTreeNode.new(position)
    @considered_positions = [position]
    build_move_tree
  end

  def build_move_tree
    start_pos = @root_node
    queue = [start_pos]
    until queue.empty?
      curr_node = queue.shift
      moves = new_move_positions(curr_node.value)
      moves.each do |move| 
        child = PolyTreeNode.new(move)
        queue.push(child)
        curr_node.add_child(child)
      end
    end
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves = moves.select{|move| !@considered_positions.include?(move)}
    @considered_positions += moves
    moves 
  end

  def find_move(curr_node, end_pos) #our DFS function
    return curr_node if curr_node.value == end_pos

    curr_node.children.each do |child|
      search_result = find_move(child, end_pos)
      return search_result if search_result != nil
    end
    nil
  end

  def trace_path_back(end_pos) #this node 
    path = []

    path << end_pos.value 

    while end_pos.parent != nil
         end_pos = end_pos.parent 
         path.unshift(end_pos.value)
    end

    path
  end

  def find_path(end_pos) #end_pos reps our target
    result = find_move(@root_node, end_pos)

    return nil if result == nil 
    path = trace_path_back(result)
    
  end

end

knight = KnightPathFinder.new([0,0])
knight.root_node.bfs_print
puts
puts 

knight = KnightPathFinder.new([2,2])
knight.root_node.bfs_print
puts

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) 
# knight = KnightPathFinder.new([0,10]) # => raises invalid starting position error
# knight = KnightPathFinder.new([-1,7]) # => raises invalid starting position error