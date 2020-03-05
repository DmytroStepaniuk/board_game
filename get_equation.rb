# ---------------->
# |
# |   0,0  0,1  0,2  0,3
# |
# |   1,0  1,1  1,2  1,3
# |
# |   2,0  2,1  2,2  2,3
# |
# v   3,0  3,1  3,2  3,3

board = [
  ['1', nil, nil, nil, nil, nil, nil, nil, nil],
  ['-', '1', '-', '1', '=', '-', '2', nil, nil],
  ['1', nil, nil, nil, nil, nil, nil, nil, nil],
  ['=', nil, nil, nil, nil, nil, nil, nil, nil],
  ['1', nil, nil, nil, nil, nil, nil, nil, nil],
  ['+', nil, nil, nil, nil, nil, nil, nil, nil],
  ['1', nil, nil, nil, nil, nil, nil, nil, nil],
  ['=', nil, nil, nil, nil, nil, nil, nil, nil],
  ['2', nil, nil, nil, nil, nil, nil, nil, nil]
]

def get_upper_element board, x, y
  return nil if x - 1 < 0

  board[x-1][y] rescue nil
end

def get_bottom_element board, x, y
  board[x+1][y] rescue nil
end

def get_left_element board, x, y
  return nil if y - 1 < 0

  board[x][y-1] rescue nil
end

def get_right_element board, x, y
  board[x][y+1] rescue nil
end

# -------------------------------------------------------------------------------------------------------------------

def get_verticalequation board, x, y
  value = board[x][y]

  #
  # CASE 1. When Cell value IS '='
  #
  if value == '='
    equation = [value]

    x.downto(0) do |x|
      upper_element = get_upper_element(board, x, y)

      break if [nil, '='].include? upper_element

      equation = [upper_element] + equation
    end

    x.upto(board.size - 1) do |x|
      bottom_element = get_bottom_element(board, x, y)

      break if [nil, '='].include? bottom_element

      equation = equation + [bottom_element]
    end
  end

  #
  # CASE 2. When Cell value IS NOT '='
  #
  if value != '='
    equation = [ value ]

    has_eq_operator = false

    x.downto(0) do |x|
      upper_element = get_upper_element(board, x, y)

      break if \
        (has_eq_operator == false && upper_element == nil) \
        ||
        (has_eq_operator == true  && upper_element == nil) \
        ||
        (has_eq_operator == true  && upper_element == '=')

      has_eq_operator = true if upper_element == '='

      equation = [upper_element] + equation
    end

    has_eq_operator = false

    x.upto(board.size - 1) do |x|
      bottom_element = get_bottom_element(board, x, y)

      break if \
          (has_eq_operator == false && bottom_element == nil) \
          ||
          (has_eq_operator == true  && bottom_element == nil) \
          ||
          (has_eq_operator == true  && bottom_element == '=')

      has_eq_operator = true if bottom_element == '='

      equation = equation + [bottom_element]
    end
  end

  equation
end

# -------------------------------------------------------------------------------------------------------------------

def get_horizontalequation board, x, y
  value = board[x][y]

  if value == '='
    equation = [value]

    y.downto(0) do |y|
      left_element = get_left_element(board, x, y)

      break if ['=', nil].include? left_element

      equation = [ get_left_element(board, x, y) ] + equation
    end

    y.upto(board[0].size - 1) do |y|
      right_element = get_right_element(board, x, y)

      break if ['=', nil].include? right_element

      equation = equation + [right_element]
    end
  end

  if value != '='
    equation = [value]

    has_eq_operator = false

    y.downto(0) do |y|
      left_element = get_left_element(board, x, y)

      break if (has_eq_operator == false && left_element == nil) \
               ||
               (has_eq_operator == true  && left_element == nil) \
               ||
               (has_eq_operator == true  && left_element == '=')

      has_eq_operator = true if left_element == '='

      equation = [left_element] + equation
    end

    has_eq_operator = false

    y.upto(board[0].size - 1) do |y|
      right_element = get_right_element(board, x, y)

      break if (has_eq_operator == false && right_element == nil) \
               ||
               (has_eq_operator == true  && right_element == nil) \
               ||
               (has_eq_operator == true  && right_element == '=')

      has_eq_operator = true if right_element == '='

      equation = equation + [right_element]
    end
  end

  equation
end

# -------------------------------------------------------------------------------------------------------------------

# Lets test it
get_horizontalequation board, 1, 0
# get_verticalequation board, 8, 0
# get_verticalequation board, 1, 0

# get_verticalequation board, 3, 3
