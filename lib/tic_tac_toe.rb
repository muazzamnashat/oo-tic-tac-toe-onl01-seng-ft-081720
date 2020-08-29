require 'pry'
class TicTacToe

    WIN_COMBINATIONS= [
        [0,1,2], #top row 
        [3,4,5], #middle
        [6,7,8], #bottom
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
        ]      
    def initialize
        @board=Array.new(9," ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1 
    end

    def move (position,token="X")
        @board[position]=token
    end
    
    
    def position_taken?(position)
        if @board[position]=="X" || @board[position]=="O"
            true
        else 
            false
        end
    end

    def valid_move?(position) 
        if position.between?(0,8) && !position_taken?(position)
            true
        else false 
        end
    end
    
    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        if turn_count % 2 == 0 
            "X"
        else 
            "O"
        end
    end

    def turn
        puts "Please enter 1-9:"
        input=gets.strip 
        valid_input=input_to_index(input)
        if valid_move?(valid_input) 
            move(valid_input,current_player)
            display_board
        else turn
        end
    end

    def won?
        WIN_COMBINATIONS.each do |i|
            win_index_1=i[0]
            win_index_2=i[1]
            win_index_3=i[2]
            position_1 = @board[win_index_1] 
            position_2 = @board[win_index_2] 
            position_3 = @board[win_index_3] 
            if position_1 == "X" && position_2 == "X" && position_3 == "X"
              return i
            elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
              return i
            end
        end
        false
    end

    def full? 
        @board.all? do |i|
        i=="X" || i=="O"
        end
    end

    def draw?
            if full? == true && won? == false
                true
            else 
                false
        end 
    end

    def over?
        if won? != false || draw? == true
            true
        else
            false
        end
    end

    def winner
        winner_index= won?
        if winner_index==false
            nil
        elsif winner_index.all? do |i|
            @board[i]=="X"
        end
            "X"
        elsif winner_index.all? do |j|
            @board[j]=="O"
        end
            "O"
        end
    end

    def play 
        until over? == true do
        turn
        play
        end

        if draw? == true
            puts "Cat's Game!"
        else
            winner_name=winner
            puts "Congratulations #{winner_name}!"
        end
    end
    
end

new=TicTacToe.new
new.play
