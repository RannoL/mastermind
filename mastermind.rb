# Welcome screen and game loop
class Mastermind
  def initialize
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

  def start_game
    @computer = Computer.new('computer')
    @player = Player.new('player')

    Colors.sample
    # Main game loop
    while @player.guesses <= 12
      guess = @player.get_guess
      puts "this is in start_game guess #{guess}"
    end

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

  def initialize(name)
    @name = name
    @code = []
    @colors = %w[r g b w c m]
    for i in 0...4
      @code << random_pick
    end
    p @code
  end

  def control_code(guess)
    guess = guess.split('')
    p guess
    # Cpeg - correct peg, Gpeg - guess peg
    @code.each_with_index do |c_peg, c_peg_i|
      guess.each_with_index do |g_peg,g_peg_i|
      end
    end

  private

  def random_pick
    @colors.sample
  end
end

# Manages player input
class Player
  attr_accessor :guesses

  def initialize(name)
    @name = name
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

Mastermind.new
