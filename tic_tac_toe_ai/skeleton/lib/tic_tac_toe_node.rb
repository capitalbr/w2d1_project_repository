require_relative 'tic_tac_toe'
require "byebug"
class TicTacToeNode # current version of the board

  attr_accessor :board, :next_mover_mark, :prev_move_pos


 

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board   # BOARD CLASS will call (.empty?(pos))
    @next_mover_mark = next_mover_mark  # :x or :o
    @prev_move_pos = prev_move_pos

  end

  def losing_node?(evaluator)
    
    if self.board.winner != evaluator
       
       if self.board.winner == nil
        return false
       else
        return true
       end
    # else 
    #   false
    end
    false
  end

  
  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.

  def children
    child = []

      if next_mover_mark == :x     #may need to go within enumerator...
        new_next = :o
      else                    # possible nit issue if bug
        new_next = :x
      end
    

      self.board.rows.each_with_index do |row, x|
        row.each_with_index do |col, y|
          if self.board.empty?([x,y])
            board_dup = self.board.dup  #returs a dup of self  # 1)create dup
            board_dup.[]=([x,y], self.next_mover_mark) # 2)place mark  (the children will get the next_mover_mark )
            child << TicTacToeNode.new(board_dup, new_next, [x,y] )  # 3)create node instance # 4:shovel into array
          end
        end
      end
    child
  end


  


end


# hello = TicTacToeNode.new(Board.new, :x)
# p hello.children
# p hello.board.rows


