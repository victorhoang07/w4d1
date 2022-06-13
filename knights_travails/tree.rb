class Tree

    attr_accessor :position, :parent, :children

    def initialize(pos) #pos = [num1, num2]
        @position = pos
        # @prev_moves = [pos] 
        @parent = nil
        @children = []
    end


    def parent=(node)
        if node.nil?
            self.parent.children.delete(self)
        elsif self.parent.nil?
            @parent = node
            node.children << self
        end
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        child.parent = nil
    end

    def dfs(target) #target = []
        return self if self.position = target
        self.children.each do |child|
            search_result = child.dfs(target)
            return search_result if !search_result.nil?
        end
        nil
    end

    # def inspect
    #     self.position
    # end

end