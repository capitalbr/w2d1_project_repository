require_relative "knight_tree_node"

require "byebug"
# A node is a child of another node if you can move from the parent position directly to the child position.
class KnightPathFinder
    attr_accessor :considered_positions, :root_node
    # [0,0]
    def initialize(pos)  #pos is an array
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        self.build_move_tree
       
        
    end
                            #first initialize, then call find_path:  init gives start_pos, find_path gives end_pos
    # [0,0]
    def find_path(end_pos)   # user calls this  method to find the shortest path to end position
        val = self.root_node.dfs(end_pos)   #.value  # gives us a node, but not the path to it
        trace_path_back(val)
    end

    def trace_path_back(val)
        #  val = self.root_node.dfs(end_pos)  # instance of poly_node class
        traced_path = []

       
        if val.nil?
            return
        end

        until val == self.root_node
          traced_path.unshift(val)
          val = val.parent
       


        end

        traced_path.unshift(val)

    end


    def self.valid_moves(pos)  # checks if a position is within the chess board dimensions.  Used in #new_move_positions
        x, y = pos[0], pos[1]
        array = [[x-1, y-2], [x+1, y-2], [x-1, y+2], [x+1, y+2],[x-2, y-1], [x-2, y+1], [x+2, y+1], [x+2, y-1]]
        
        new_array = array.map do |pos|
            pos
        end

        new_array.select do |pos|
            x = pos[0]
            y = pos[1]
            (x >= 0 && x < 8) && (y >= 0 && y < 8)
        end
    end

    def new_move_positions(pos)
        array = KnightPathFinder.valid_moves(pos)     # selects only moves that won't jump the player off the board
       
        newmoves = array.reject { |ele| self.considered_positions.include?(ele)}
        newmoves.each do |ele|
            self.considered_positions << ele   # keeping track of where this node has been
        end
        
        newmoves # an array possible_new_moves (our tree/map to build move tree with)
    end

    #  1
    # 3 5


    def build_move_tree

       
        array = [self.root_node]
        
        
        until array.empty?


            first = array.shift #.first

            next_newmoves = new_move_positions(first.value)
            
            next_newmoves.each do |ele|
                first.add_child(PolyTreeNode.new(ele))
                   
            end
           
            first.children.each do |ele|
                array << ele
            end
       
          
                        
        end
        
       
    end
        
  
end




# PolyTreeNode.bfs


#                         #         2,3    2,5                                
#                         #   3,2                 3,6
#                         #   5,2       4,4       5,6 
                                    
#                         #         6,3    6,5

hey = KnightPathFinder.new([0,0])
p hey.find_path([6,2])



# p hey.new_move_positions([1, 4])
# p hey.new_move_positions([2, 4])
# p hey.new_move_positions([5, 4])
# p hey.new_move_positions([2, 4])
# p hey.new_move_positions([4, 4])
# p hey.new_move_positions([3, 4])