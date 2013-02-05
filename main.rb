#tictactoe
#=========
  class Game
    
      
    def greeting
      puts "\n"*20
      # E for empty
       puts "Welcome to Tic Tac Toe"
       puts "Game board looks like:\n"
       puts "1 | 2 | 3"
       puts "4 | 5 | 6"
       puts "7 | 8 | 9"
       
       puts "select 1 through 9 to select move."
       
    end
    
    def game_play

      @board = [1,2,3,
                4,5,6,
                7,8,9]
      @winning_rows = [     #just defining all 8 possible winds which will be searched for analyzing positions, ties, and wins.
                   [0,1,2],
                   [0,3,6],
                   [1,4,7],
                   [2,5,8],
                   [3,4,5],
                   [6,7,8],
                   [0,4,8],
                   [2,4,6],
                   ]

      @newb = "X" 
      @comp = "O"

      @gameover = false
      starts = who_starts
      
      while @gameover == false
        
        if starts == 0
          user_move
          starts +=1    
        else
          computer_move
          starts -=1
        end
      end
    end
      
    def who_starts
      coin = ["HEADS", "TAILS"] 
      coinflip = coin[rand(2)]
      
      loop do
        puts "Ok newbie, select [heads] or [tails]"
        guess = gets.chomp
        guess = guess.upcase
        
        if guess !~ /heads|tails/i
          puts "Really?  Come on, try again, buddy..."
          redo
        end
        
         puts "coin flip is.......:" + coinflip
        
        if guess == coinflip
          puts "Newbie goes first."
          return 0
          break
        else
          puts "Computer goes first."
          return 1
          break
        end
      end
    end

    def draw_board    #drawing board
      puts "-----------------------------------------------------------"
      puts "|\t#{@board[0]}\t|\t#{@board[1]}\t|\t#{@board[2]}\t|"  
      puts "|\t#{@board[3]}\t|\t#{@board[4]}\t|\t#{@board[5]}\t|"
      puts "|\t#{@board[6]}\t|\t#{@board[7]}\t|\t#{@board[8]}\t|"
       puts "-----------------------------------------------------------"
    end   

    def user_move
      puts "Current board is:\n\n"
      draw_board
      puts "___________________"
      puts "Accepting move:\n"
      
      loop do
        move = gets.chomp    # gets receives input from console, chomp cleans off any trailing white space 
        if @board[move.to_i-1] == @newb || @board[move.to_i-1] == @comp      #Can't take a spot that's taken
          puts "You blind??  Spot not available!"
          redo
        else
          @board[move.to_i-1] = @newb
          break
        end 
      end
      puts "___________________\n\n"
      draw_board
      
      if win_game(@newb) == 1
        puts "Thatta a boy!  You won!\n\n"
        draw_board
        @gameover = true
      end
      if tie_game == false
        puts "Eh, game's is a tie!!\n"
        draw_board
        @gameover = true
      end
      
    end
  
    def computer_move
      puts "Computer's Move"
      move = best_move
      @board[move] = @comp
      
      if win_game(@comp) == 1
        puts "Ouch.  Computer wins!\n\n"
        draw_board
        @gameover = true
      end
      if tie_game == false
        puts "Game is a tie!!\n"
        draw_board
        @gameover = true
      end
    end
  
    def tie_game   #Tie if no numbers exist.  Could change to check for X's and O's
      return @board.any?{|num| (1..9).include?(num)}
    end
 
    def win_game(player)    #If one player has all 3 in a row = win.
      if player == @newb
          @winning_rows.each do |row|
            if num_in_row(row, @newb) == 3
              return 1
            end
          end
      else
        @winning_rows.each do |row|
          if num_in_row(row, @comp) == 3
            return 1
          end
        end
      end
    end
 
 
 # DEFINING COMPUTER MOVES! -----------------
 
    def best_move
      
      @winning_rows.each do |row|        #Check if comp has 2 pieces in a row - can win next move
        if num_in_row(row, @comp) == 2   #Checks for empty positions options above.  Can probably improve
          row.each do |i|                # this too since this takes the first option which may not be the best strategic move.
            if @board[i] != @newb && @board[i] != @comp 
              return i
            end
          end
        end
      end
      @winning_rows.each do |row|       #Check if newb has 2 pieces in a row - can win next move
        if num_in_row(row, @newb) == 2  
          row.each do |i|              
            if @board[i] != @newb && @board[i] != @comp 
              return i
            end
          end
        end
      end
      @winning_rows.each do |row|      #Check if comp has 1 piece in a row
        if num_in_row(row, @comp) == 1
          row.each do |i|           
            if @board[i] != @newb && @board[i] != @comp 
              return i
            end
          end
        end
      end
      
      loop do                        #Nada in rows -> random.  Probably can improve this so a better strategic move is possible.
        i = rand(8)
        if @board[i] == @newb || @board[i] == @comp
          redo
        end
         return i
        break
      end      
    end

         
    def num_in_row(row, player)    #Solves the logic above for determining how many pieces per row.
      number = 0                      #Critical!!! Opposing_player logic ensures that code does not
      opposing_num = 0                #get stuck if an entire row is full and a win is not available.
      if player == @newb
        opposing_player = @comp
      else
        opposing_player = @newb
      end
      row.each do |i|
        number += 1  if @board[i] == player 
        opposing_num +=1 if @board[i] == opposing_player
        if number == 2 && opposing_num == 1
          return 0
        end
      end
      number
    end
    

# COMPUTER MOVES ENDING--------------------------------------------------------    
    
    
  end


#-----------------------------   Main Script Logic----------------------------------------   

New_game = Game.new

New_game.greeting
New_game.game_play
