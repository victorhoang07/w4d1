require "set"
require_relative "tree.rb"
require "byebug"


class KnightPathFinder
    attr_reader :root_node, :considered_positions, :starting_position
    attr_accessor :visited
    def initialize(starting_position)
        raise "not valid position" if !valid?(starting_position)
        @root_node = Tree.new(starting_position)
        @starting_position = starting_position
        @considered_positions = [@root_node]
    end

    # def []
    #end
    # def []=
    #end

    def valid?(pos)
        first = pos[0]
        last = pos[1]
        return false if first < 0 || first > 7
        return false if last < 0 || last > 7
        true
    end

    def new_move_positions(node)
        pos = node.position
        new_positions1 = [pos[0] + 1, pos[1] + 2]
        new_positions2 = [pos[0] + 2, pos[1] + 1]
        p1 = true
        p2 = true
        p1 = false if !valid?(new_positions1)
        p2 = false if !valid?(new_positions2)   
        
        ret_val = []

        @considered_positions.each do |node2|
            if node2.position == new_positions1
                p1 = false
            end
            if node2.position == new_positions2
                p2 = false
            end
            break if !p1 && !p2
        end
        if p1
            left = Tree.new(new_positions1)
            left.parent = node
            @considered_positions << left
            ret_val << left
        end
        if p2
            right = Tree.new(new_positions2)
            right.parent = node
            @considered_positions << right
            ret_val << right
        end
        ret_val
    end
            
    def build_move_tree
        queue = [@root_node]

        until queue.empty?
            # p queue
            node = queue.shift
            new_pos = new_move_positions(node)
            new_pos.each {|ele| queue << ele}
        end
        return @considered_positions
    end
end

root = KnightPathFinder.new([0,0])
# root.new_move_positions(root.root_node)
p root.build_move_tree