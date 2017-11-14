require "byebug"

require "colorize"
require_relative "cursor"
require_relative "board"

class Display

LETTERS = %w(A B C D E F G H)

  attr_reader :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    test_idx = 0
      while test_idx < 20
      
      c_coor = @cursor.cursor_pos
      is_selected? ? c_color = color_selected(@board[c_coor]) : c_color = color(@board[c_coor])
      
      system("clear")
      puts "    0   1   2   3   4   5   6   7"
      @board.grid.each_with_index do |row, i|
        print "  ---------------------------------\n"
        print "#{LETTERS[i]} "
        row.each_index do |j|
          pos = [i, j]
          c_coor == pos ? (print "|#{c_color}") : (print "|#{@board[pos]}")
          print "|\n" if j == 7
        end
      end
      print "  ---------------------------------\n"
      
      @cursor.get_input

      test_idx += 1
    end
  end
  
  def color_selected(arg)
    arg.to_s.colorize(:background => :light_red)
  end
  
  def color(arg)
    arg.to_s.colorize(:background => :light_black)
  end
  
  def is_selected?
    @cursor.selected
  end
end


