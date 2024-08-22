# frozen_string_literal: true

require_relative('display')
require_relative('hangman')

# Entry point to start the game loop
class MainMenu
  SAVE_LOCATION = './saves/save.yml'
  def menu
    Display.main_menu_prompt
    gets.chomp.downcase.eql?('y') ? load_file : new_game
    game.loop
  end

  def new_game
    self.game = Hangman.new(8)
  end

  def load_file
    return no_save_file unless File.exist?(SAVE_LOCATION)

    self.game = Hangman.load(SAVE_LOCATION)
  end

  private

  def no_save_file
    puts 'No save file is detected. Starting a new game...'
    new_game
  end

  attr_accessor :game
end
