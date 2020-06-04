# Welcome screen and game loop
class Mastermind
  def initialize
    put_welcome_banner
  end

  private

  def put_welcome_banner
    require 'io/console'
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

end

# Handles coloring text and putting sampels
class Colors
  require 'colorize'

  def self.sample
    print '  r  '.colorize(:color => :white, :background => :red)
    print '  g  '.colorize(:color => :white, :background => :green)
    print '  b  '.colorize(:color => :white, :background => :blue)
    print '  w  '.colorize(:color => :black, :background => :white)
    print '  c  '.colorize(:color => :white, :background => :cyan)
    print '  m  '.colorize(:color => :white, :background => :magenta)
    puts
    puts
  end
end

Mastermind.new
