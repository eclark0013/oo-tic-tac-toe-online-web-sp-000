require "pry"

class TicTacToe
  attr_accessor :board, :current_player, :selection_index
  attr_reader  :game_status

  def initialize
    @board=[" ", " ", " ", " ", " ", " ", " ", " ", " "]

  end

  #binding.pry
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # bottom column
    [0,3,6],  # left column
    [1,4,7],  # center column
    [2,5,8],  # right column
    [0,4,8],  # diagonal 1
    [2,4,6]  # diagonal 2
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input = input.to_i
    input-1
  end

  def move(index,character)
    @board[index]="#{character}"
  end

  def position_taken?(position)
    @board[position] != " "
  end

  def good_number(num)
    num>=0 && num<=8
  end


  def valid_move?(position)
    good_number(position) && !(position_taken?(position))
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  #def ask_for_selection
  #  puts "Please enter a number 1-9:"
  #  @selection_index = input_to_index(gets)
  #end

  def turn
    puts "Please enter a number 1-9:"
    input = gets.strip
    spot = input_to_index(input)
    until valid_move?(spot)
      puts "Please enter a number 1-9:"
      input = gets.strip
      spot = input_to_index(input)
    end
    move(spot, current_player)
    display_board
  end


  def X_win?
    status=false
    WIN_COMBINATIONS.each do |array|
      status=true if array.all? {|value| @board[value]=="X"}
    end
    status
  end

  def O_win?
    status=false
    WIN_COMBINATIONS.each do |array|
      status=true if array.all? {|value| @board[value]=="O"}
    end
    status
  end

  def won?
   if X_win? == true
     winning_combination=nil
     WIN_COMBINATIONS.detect do |combo|
       if combo.all? {|num| @board[num]=="X"}
         winning_combination=combo
       end
     end
     winning_combination

   elsif O_win? == true
     winning_combination=nil
     WIN_COMBINATIONS.detect do |combo|
       if combo.all? {|num| @board[num]=="O"}
         winning_combination=combo
       end
     end
     winning_combination

    else
     false
   end

  end


  def full?
    @board.none? {|letter| letter==" "}
  end

  def empty_spots?
    !full?
  end

  def draw?
    if won?
      false
    elsif empty_spots?
      false
    else
      true
    end
  end

  def over?
    draw? || won?
  end

  def winner
    if X_win?
      "X"
    elsif O_win?
      "O"
    else
      nil
    end
  end

  def play
    until over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end

end
