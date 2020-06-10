# Welcome screen and game loop
class Mastermind
  def initialize
    @computer = Computer.new
    @player = Player.new
    @controller = Controller.new
    @code = @computer.code
    put_welcome_banner
  end

  private

  def put_welcome_banner
    banner = File.read('textFiles/banner.txt')
    puts banner.center(1000)
    put_tutorial
  end

  def wait_to_continue
    require 'io/console'
    puts
    puts 'Press any key to continue: '
    puts
    STDIN.getch
  end

  def put_tutorial
    welcome_text1 = File.foreach('textFiles/welcome_text.txt').first(7)
    welcome_text2 = File.foreach('textFiles/welcome_text.txt').drop(7)
    puts welcome_text1
    Colors.sample
    wait_to_continue
    puts welcome_text2
    wait_to_continue
    start_game
  end

  # Main game loop
  def start_game
    Colors.sample
    while @player.guesses <= 12 && @code != @controller.guessed_code
      guess = @player.get_guess
      @controller.control_guess(guess, @code)
    end
    puts
    if @controller.guessed_code == @code
      puts 'Congratulations, you are a mastermind!'
    else
      puts 'Better luck next time.'
    end
    puts
  end

end

# Handles coloring text and putting sampels
class Colors
  require 'colorize'

  def self.sample
    puts 'Input your guess with 4 letters chosen from: '
    print '  r  '.colorize(:color => :white, :background => :red)
    print '  g  '.colorize(:color => :white, :background => :green)
    print '  b  '.colorize(:color => :white, :background => :blue)
    print '  w  '.colorize(:color => :black, :background => :white)
    print '  c  '.colorize(:color => :white, :background => :cyan)
    print '  m  '.colorize(:color => :white, :background => :magenta)
    puts
  end
end

# Generates code and analyses users guess
class Computer
  attr_accessor :code

  def initialize
    @code = []
    random_pick
  end

  private

  def random_pick
    @colors = %w[r g b w c m]
    for i in 0...4
      random_pick = @colors.sample
      @code << random_pick
    end
    #p @code
  end
end

# Manages player input
class Player
  attr_accessor :guesses

  def initialize
    @guesses = 1
  end

  def get_guess
    loop do
      puts
      puts "Guess #{@guesses}: "
      guess = gets.chomp
      if validate_guess(guess)
        @guesses += 1
        return guess
      end
    end
  end

  private

  def validate_guess(guess)
    if guess =~ /\A[rgbwcm]{4}\z/
      true
    else
      puts
      print "#{Colors.sample}"
      false
    end
  end
end

# Controlles and keeps track of the guessed code
class Controller
  attr_accessor :guessed_code
  def initialize
    @guessed_code = []
  end

  def control_guess(guess, code)
    guess = guess.split('')
    puts
    code.each_with_index do |c_peg, c_peg_i|
      if guess.include?(c_peg)
        if guess[c_peg_i] == c_peg
          @guessed_code[c_peg_i] = c_peg
          puts "#{c_peg_i + 1}. peg is correct!"
        else
          puts "#{c_peg_i + 1}. peg is right, but at the wrong position"
        end
      else
        puts "#{c_peg_i + 1}. peg is false."
      end
    end
  end
end

Mastermind.new
