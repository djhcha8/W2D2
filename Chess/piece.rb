require "singleton"



module Stepable
  def moves
    move_diffs.map { |delta| [self.pos.first + delta.first, self.pos.last + delta.last] }
  end
  
  def move_diffs
    raise NotImplementedError.new("Need a move_diffs method.")
  end
end

module Slideable
  def moves
    if move_dirs.include?(:diagonal) && move_dirs.include?(:horizontal)
      diagonal_dirs.map { |delta| [self.pos.first + delta.first, self.pos.last + delta.last] } +
      horizontal_dirs.map { |delta| [self.pos.first + delta.first, self.pos.last + delta.last] }
    elsif move_dirs.include?(:diagonal)
      diagonal_dirs.map { |delta| [self.pos.first + delta.first, self.pos.last + delta.last] }
    elsif move_dirs.include?(:horizontal)
      horizontal_dirs.map { |delta| [self.pos.first + delta.first, self.pos.last + delta.last] }
    end
  end
  
  def move_dirs
    raise NotImplementedError.new("Need a move_dirs method.")
  end
  
  def horizontal_dirs
    result = []
    (-7..7).each do |n|
      result << [0, n]
      result << [n, 0]
    end
    result
  end
  
  def diagonal_dirs
    result = []
    (-7..7).each { |i| result << [i, i] && result << [-i, i] }
    result
  end
  
  def grow_unblocked_moves_in_dir(dx, dy)
  end
end


class Piece
  attr_reader :symbol, :color, :pos
  
  def initialize(color = nil, pos = nil, board)
    @color = color
    @pos = pos
    @board = board
    @symbol = nil
  end
  
  def to_s
    "   "
  end
  
  def empty?
  end
  # 
  # def symbol
  # end 
  
  def valid_moves
  end 
  
  def move_into_check(to_pos)
  end
end

class King < Piece
  include Stepable
  
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :king
  end
  
  def to_s
    self.color == :white ? " ♔ " : " ♚ "
  end
  
  def move_diffs
    king_delta = [[0,1], [0,-1], [1,0], [-1,0], [1,1], [-1,1], [-1,-1], [1,-1]]
  end
end

class Knight < Piece
  include Stepable
  
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :knight
  end
  
  def to_s
    self.color == :white ? " ♘ " : " ♞ "
  end
  
  def move_diffs
    knight_delta = [[1,2], [2,1], [-1,2], [-2,1], [-1,-2], [-2,-1], [1,-2], [2,-1]]
  end 
end

class Bishop < Piece
  include Slideable
  
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :bishop
  end
  
  def to_s
    self.color == :white ? " ♗ " : " ♝ "
  end
  
  def move_dirs
    [:diagonal]
  end 
  
end 

class Rook < Piece
  include Slideable

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :rook
  end
  
  def move_dirs
    [:horizontal]
  end
  
  def to_s
    self.color == :white ? " ♖ " : " ♜ "
  end
end

class Queen < Piece
  include Slideable

  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :queen
  end
  
  def to_s
    self.color == :white ? " ♕ " : " ♛ "
  end
  
  def move_dirs
    [:diagonal, :horizontal]
  end
end

class Pawn < Piece
  
  def initialize(color, pos, board)
    super(color, pos, board)
    @symbol = :pawn
  end
  
  def to_s
    self.color == :white ? " ♙ " : " ♟ "
  end
  
  def moves
  end
  
  def at_start_row?
  end
  
  def forward_dir
  end
  
  def forward_steps
  end 
  
  def slide_attacks
  end
end

class NullPiece < Piece
  include Singleton
  
  def initialize
  end
  
  def moves
  end
end
