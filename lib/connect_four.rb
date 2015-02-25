class ConnectFour
  def self.win?(board)
    game = self.new(board)
    game.has_win?
  end

  def initialize(board)
    @board = board
  end

  def has_win?
    has_horizontal_win? || has_vertical_win? || has_diagonal_win?
  end

  private
  attr_reader :board

  def has_horizontal_win?
    board.any?{|row| row_has_win?(row) }
  end

  def has_vertical_win?
    board.transpose.any?{|column| row_has_win?(column)}
  end

  def has_diagonal_win?
    (0...board.size).each do |side_start|
      right_row = extract_right_diagonal_row(board, side_start, 0)
      return true if row_has_win?(right_row)
      left_row = extract_left_diagonal_row(board, side_start, board[0].size - 1)
      return true if row_has_win?(left_row)
    end

    (1...board[0].size).each do |top_start|
      right_row = extract_right_diagonal_row(board, 0, top_start)
      return true if row_has_win?(right_row)
      left_row = extract_left_diagonal_row(board, 0, top_start)
      return true if row_has_win?(left_row)
    end
    false
  end

  def extract_right_diagonal_row(board, col, row)
    result = []
    x = col
    y = row
    while x < board[0].size && y < board.size
      result << board[y][x]
      x += 1
      y += 1
    end
    result
  end

  def extract_left_diagonal_row(board, col, row)
    result = []
    x = col
    y = row
    while x < board[0].size && y < board.size
      result << board[y][x]
      x -= 1
      y += 1
    end
    result
  end

  def row_has_win?(row)
    current_value = "_"
    current_count = 0
    row.each do |cell|
      if current_value != cell
        current_value = cell
        current_count = 0
      end
      current_count += 1
      return true if current_count >= 4 && %w(R B).include?(current_value)
    end
    false
  end

end
