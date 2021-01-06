WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def input_to_index(input)
  index = input.to_i - 1
end
def move(board,index,character)
  board[index] = character
end
def position_taken?(board,index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    false
  else
    true
  end
end
def valid_move?(board,index)
  if position_taken?(board,index) == false && index.between?(0,8)
    true
  else
    false
  end
end
def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  counter
end
def current_player(board)
  if turn_count(board) == 0
    "X"
  elsif turn_count(board) % 2 == 0
    "X"
  elsif turn_count(board) % 2 == 1
    "O"
  end
end
def turn(board)
  puts "please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index) == true
    move(board,index,current_player(board))
  else
    turn(board)
  end
end
def won?(board)
  WIN_COMBINATIONS.each do |combination|
    position_1 = combination[0]
    position_2 = combination[1]
    position_3 = combination[2]
    if board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X"
      return combination
    elsif board[position_1] == "O" && board[position_2] == "O" && board[position_3] == "O"
      return combination
    end
  end
  false
end
def full?(board)
  taken = 0
  counter = 0
  until counter == 9
    if position_taken?(board, counter) == true
      taken += 1
    end
    counter += 1
  end
  if taken == 9
    true
  else
    false
  end
end
def draw?(board)
  if won?(board) != false || full?(board) == false
    false
  else
    true
  end
end
def over?(board)
  if won?(board) != false || draw?(board) == true
    true
  else
    false
  end
end
def winner(board)
  if won?(board) == false
    nil
  else
    winner = won?(board)
    winner_position = winner[0]
    return board[winner_position]
  end
end
def play(board)
  until over?(board) == true
    turn(board)
    display_board(board)
  end
  if draw?(board) == true
    puts "Cat's Game!"
  else
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
end
