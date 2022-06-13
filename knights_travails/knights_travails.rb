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
        one = [-1, 1]
        two = [-2, 2]
        possible_positions = []

        one.each do |ele|
            two.each do |ele2|
                new_pos = [pos[0] + ele, pos[1] + ele2]
                new_pos2 = [pos[0] + ele2, pos[1] + ele]
                if valid?(new_pos) && !already_considered?(new_pos)
                    new_node = Tree.new(new_pos)
                    new_node.parent = node
                    possible_positions << new_node
                    @considered_positions << new_node
                end
                if valid?(new_pos2) && !already_considered?(new_pos2)
                    new_node2 = Tree.new(new_pos2)
                    new_node2.parent = node
                    possible_positions << new_node2
                    @considered_positions << new_node2
                end
            end
        end

        possible_positions
    end

    def already_considered?(pos)
        @considered_positions.each do |node|
            if node.position == pos
                return true
            end
        end
        return false
    end
                
            
    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            # debugger
            node = queue.shift
            new_pos = new_move_positions(node)
            new_pos.each do |ele| 
                queue << ele
            end
        end
        return @root_node #@considered_positions
    end

    def find_path(end_pos)
        node = self.build_move_tree.dfs(end_pos)
        trace_path_back(node)
    end

    def trace_path_back(node)
        return nil if node.nil?
        parents = []
        current_node = node
        while current_node != @root_node
            parents.unshift(current_node.position)
            current_node = current_node.parent
        end
        parents.unshift(@root_node.position)
        parents
    end

end

root = KnightPathFinder.new([0,0])
# p root.new_move_positions(root.root_node)
# p root.new_move_positions(node)
# b = root.new_move_positions(a.root_node)
# c = root.new_move_positions(b.root_node)
# p c
# p root.build_move_tree
p root.find_path([7,6])