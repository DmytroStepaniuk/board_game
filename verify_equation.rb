# ---------------->
# |
# |   0,0  0,1  0,2  0,3
# |
# |   1,0  1,1  1,2  1,3
# |
# |   2,0  2,1  2,2  2,3
# |
# v   3,0  3,1  3,2  3,3

# ------------------------------------------------------------------------------------------------------------------------------

#
# ['-', '1', '+', '2', '=', '1']  ===> [ ['-', '1', '+', '2'], ['1'] ]
#
def split_equatation_into_expressions equatation
  expressions = []

  expression = []

  equatation.each do |value|
    if value == '='
      expressions.push expression

      expression = []
    else
      expression.push value
    end
  end

  expressions.push expression

  expressions
end

#
# ['-', '1', '+', '2']  ===> [ ['1'], ['2'] ]
#
def split_expression_into_numbers expression
  numbers = []

  number  = []

  expression.each do |value|
    if ['+', '/', '*', '-'].include? value
      numbers.push number

      number = []
    else
      number.push value
    end
  end

  numbers.push number

  numbers
end

#
# ['1', '0'] ===> VALID
# ['0', '0'] ===> INVALID
# number - IS an ARRAY that contains digits
#
def number_is_valid? number
  true if number.join('').to_i.to_s == number.join('')
end

#
# -1-1  VALID
# ----1 INVALID
# expression - IS an ARRAY that contains digits and operators
#
def expression_has_valid_structure? expression
  return if expression.size == 0

  return unless ['-', '1', '2', '3', '4', '5', '6', '7', '8', '9'].include? expression[0]

  return if expression[0] == '-' && !['1', '2', '3', '4', '5', '6', '7', '8', '9'].include?(expression[1])

  expression.each_with_index do |value, index|
    if ['+', '/', '*', '-'].include?(value) && !['-', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].include?(expression[index + 1])
      return
    elsif value == '-' && !['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].include?(expression[index + 1])
      return
    end
  end

  true
end

#
# 1 + 1 == 2 - 0
#
# expressions - ARE ARRAYS of expressions and each of them contains digits and operators
def expressions_equals? expressions
  results = expressions.map { |expression| eval(expression.join('')) }

  results.uniq.size == 1
end

# ------------------------------------------------------------------------------------------------------------------------------

p expressions_equals? [ ['1'], ['2', '-', '1'] ]

p expression_has_valid_structure? ['-', '-', '1']
