class PolyTreeNode
    attr_reader :parent, :children, :value
    
   
    def initialize(value)
        @value = value
        @children = []  #PolyTreeNode.new
        @parent = nil #PolyTreeNode.new
        
    end
  def inspect
    @value.inspect
  end

#SELF IS CHILD
#POLY IS PARENT
#FIXED IT
    def parent=(poly_instance)
        prior_parent = @parent
    
        @parent = poly_instance
        if poly_instance == nil
            return
        end

        if !poly_instance.children.include?(self)
            
            if prior_parent != nil
                prior_parent.children.delete(self)  #self => PolyTreeNode.new
            end
            poly_instance.children << self
            
        end
    end



    # SELF IS PARENT
    def add_child(child_node)
        child_node.parent = self
    end

    # SELF IS PARENT
    # CHILD_NODE IS CHILD
    def remove_child(child_node)
        if !self.children.include?(child_node)
        raise "not a child"
        end
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        
        if self.children.empty?
        # if self == nil
            return nil
        end
        self.children.each do |child|
            val = child.dfs(target_value)
           if val 
            return val
           end
        end
        nil
    end

    require "byebug"
    def bfs(target_value)
        array = []
        array << self
        
        until array.empty?
            first = array.shift #.first
            first.children.each do |ele|
                    array << ele
            end
           
            return first if first.value == target_value
                        
        end
       
    end


end

