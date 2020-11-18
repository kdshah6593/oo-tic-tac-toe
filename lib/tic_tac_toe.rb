require 'pry'
class TicTacToe

    def initialize
        @board = Array.new(9, " ")
    end
    
    WIN_COMBINATIONS = [
        [0,1,2], #Top Row
        [3,4,5], #Middle Row
        [6,7,8], #Bottom Row
        [0,3,6], #Left Column
        [1,4,7], #Center Column
        [2,5,8], #Right Column
        [0,4,8], #Left Diagonal
        [2,4,6] #Right Diagonal
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        index = input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
        @board
    end

    def position_taken?(index)
        if @board[index] == " "
            false
        else
            true
        end
    end

    def valid_move?(index)
        if index.between?(0,8) != true
            false
        else
            position_taken?(index) == true ? false : true
        end
    end

    def turn_count
        @board.count {|position| position == "X" || position == "O"}
    end

    def current_player
        turn_count.even? == true ? "X" : "O"
    end
    
    def turn
        puts "Please choose a position 1-9:"
        user_input = gets.chomp
        index = input_to_index(user_input)
        player = current_player
        if valid_move?(index) == true
            move(index, player)
            display_board
        else
            turn
        end
    end

    def won?
        result = false
        WIN_COMBINATIONS.each do |combination|
            position1 = @board[combination[0]]
            position2 = @board[combination[1]]
            position3 = @board[combination[2]]

            if position1 == "X" && position2 == "X" && position3 == "X"
                result = combination
            elsif position1 == "O" && position2 == "O" && position3 == "O"
                result = combination
            end
        end
        result
    end

    def full?
        @board.all? {|position| position == "X" || position == "O"}
    end

    def draw?
        if full? == true && won? == false
            true
        else 
            false
        end
    end

    def over?
        if draw? == true || won? != false
            true
        else
            false
        end
    end

    def winner
        win_player = won?
        if won? == false
            nil
        else
            @board[win_player[0]]
        end
    end

    def play
        until over? == true
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

end