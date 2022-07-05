class Player
    attr_reader :symbol
    attr_reader :name
    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end

end


class Game
    @@winner = false
    @@play = true
    def play_game()
        while @@play
            playing_board = Board.new()

            puts "Enter the name of the first player"
            name_1 = gets.chomp 
            player_1 = Player.new(name_1, '0')
            puts "Enter the name of the second player"
            name_2 = gets.chomp
            player_2 = Player.new(name_2, 'x')
            
            while @@winner == false
                playing_board.make_move(player_1)
                playing_board.check_winner(player_1)
                if @@winner == true
                    break
                end
                playing_board.make_move(player_2)
                playing_board.check_winner(player_2)
            end
            puts "Do you want to play again? press 'y' for yes 'n' for no. "
            ans = gets
            if ans == 'n'
                @@play = false
            end
        end
    end
    def declare_result(player)
        puts "#{player.name} wins!"
        @@winner = true
    end
end

class Board < Game
    def initialize()
        @new_board = Array([[ 1 , 2 , 3 ],
                      [ 4 , 5 , 6 ],
                      [ 7 , 8 , 9 ]])
    end
    def  update_board(value, symbol)
        @new_board.each_index{|row| @new_board[row].include?(value)? (@new_board[row][@new_board[row].index(value)] = symbol) : ()}
    end 
    def print_board
        @new_board.each {|row| p row}
    end
    def make_move( player)
        print_board()
        puts "Enter the number you want to replace with your symbol,  #{player.name}"
        number = gets
        number = number.to_i
        if @new_board.flatten.include?(number)
            update_board(number, player.symbol)
        else
            puts "Make a valid move"
            make_move(player)
        end
    end
    def check_winner(player)
        for i in 0..2
            if @new_board[i][0] == @new_board[i][1] && @new_board[i][0] == @new_board[i][2]
                declare_result(player)
            end
        end
       if @new_board[0][0] == @new_board[1][1] && @new_board[0][0] == @new_board[2][2]
        declare_result(player)
        
       elsif @new_board[2][0] == @new_board[1][1] && @new_board[2][0] == @new_board[0][2]
        declare_result(player)
       end
       for i in 0..2
            if @new_board[0][i] == @new_board[1][i] && @new_board[0][i] == @new_board[2][i]
                declare_result(player)
            end
        end
    end

end



new_game = Game.new()
new_game.play_game()