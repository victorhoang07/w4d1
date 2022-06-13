require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark
  attr_accessor :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board #[[nil, nil, nil], [nil,nil,nil], [nil,nil.nil]]
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # def losing_node?(evaluator)
  # end

  # def winning_node?(evaluator)
  # end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    ret_val = []
    (0..2).each do |idx|
      (0..2).each do |idx2|
        dup = @board.dup
        pos = [idx, idx2]
        if dup[pos].nil?
          dup[pos] = @next_mover_mark
          next_mark = :x
          if @next_mover_mark == :x
            next_mark = :o 
          else
            next_mark = :x
          end
          ret_val << TicTacToeNode.new(dup, next_mark, pos)
        end
      end
    end
    ret_val
  end

  def losing_node?(mark)
    if board.over?
      return false if @board.winner == mark 
      return true if @board.winner != mark || @board.winner.nil?
    end
    future = self.children
    arr = []
    future.each do |dr_strange|
      arr << losing_node?(dr_strange.next_mover_mark)
    end
    arr.all? { false }
  end

end
