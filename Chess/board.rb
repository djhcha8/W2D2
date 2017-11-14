require "byebug"
require_relative "piece"
PIECES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

class Board
  attr_reader :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end
  
  def [](pos)
    row, col = pos
    @grid[row][col]
  end
  
  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end
  
  def move_piece(start_pos, end_pos)
    if in_bounds?(start_pos) || in_bounds?(end_pos)
      raise "Invalid move. Position is outside of the board"
    elsif self[start_pos].is_a?(NullPiece)
      raise "Invalid move. There isn't a piece on your starting position."
    elsif !self[end_pos].is_a?(NullPiece)
      raise "Invalid move. There is a piece already there."
    end
    
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
  end
  
  def in_bounds?(pos)
    pos.any? { |num| num > 7 || num < 0 }    
  end
  
  def populate
    @grid.size.times do |row|
      @grid.size.times do |col|
        pos = [row, col]
        if row == 0
          self[pos] = PIECES[col].new(:black, [row, col], self)
        elsif row == 7
          self[pos] = PIECES[col].new(:white, [row, col], self)
        elsif row == 1
          self[pos] = Pawn.new(:black, [row, col], self)
        elsif row == 6
          self[pos] = Pawn.new(:white, [row, col], self)
        else
          self[pos] = NullPiece.instance
        end
      end
    end
    
  end
end