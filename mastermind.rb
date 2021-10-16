# Intro, instructions
# Maker or braker

# IF breaker
  # generate code

  # ask for a guess
  # give result
  # if not correct REPEAT

# IF Maker
  # enter code

  # ask for a guess
  # give result
  # if not correct REPEAT

module ErrorMsg
  def try_again
    puts 'Error! Try again'
    puts ''
  end
end


class Game
  extend ErrorMsg

  
  def initialize
    @game_mode = nil
    @code = []
    @guess
    @game_won = false
    @times_played = 0
  end

  def introduction
    puts 'Welcome to the game "Mastermind"'
    puts ''
    puts 'In this game the CODEMAKER thinks of a code, and the CODEBREAKER tries to guess it.'
    puts ''
    puts 'After a guess, clues (in random order) are shown:'
    puts 'X - if the number and the position is correct'
    puts 'O - if only the number is correct'
    puts ''
    puts 'Example - the CODE is "1234", the GUESS is "6243".'
    puts 'The clue would be - OOX.'
    puts 'OO for the 4 and 3 (correct numbers, but wrong positions)'
    puts 'X for the 2 (correct number and position)'
    puts ''
  end

  def game_mode?
    until @game_mode
      puts 'Type: 1 for CODEMAKER, 2 for CODEBREAKER'
      gm = gets.chomp.to_i
      if [1, 2].include? gm
        @game_mode = gm
      else
        Game.try_again
      end
    end
  end

  def generate_code
    4.times { @code.push(rand(1..6).to_s) }
    # p @code
  end

  def enter_guess
    @guess = nil
    until @guess
      puts 'enter your guess. Reminder: four numbers, 1-6'
      g = gets.chomp.split("")
      if g.length == 4 && g.all? { |e| e.to_i.between?(1, 6) }
        @guess = g
      else
        Game.try_again
      end
    end
  end

  def check_win?
    if @code == @guess
      puts 'You are the winner!!!'
      @game_won = true
    else
      false
    end

  end

  def give_clues
    clues = []

    @guess.each_with_index do |item, idx|
      if @code[idx] == item
        clues.push('X')
      elsif @code.include? item
        clues.push('O')
      end
    end

    puts clues.sort.join(' ')
  end

  def play
    introduction
    game_mode?
    generate_code

    until @game_won || @times_played == 12
      enter_guess
      if check_win? == false
        give_clues
      end
      @times_played += 1
    end

    puts 'Too many attempts. You lost :('
  end


end


game = Game.new
game.play
