# frozen_string_literal: true

require_relative('display')
require_relative('hangman')

# Entry point to start the game loop
class MainMenu
  def menu; end

  def new_game
    self.game = Hangman.new(8)
    game.loop
  end

  def load_file; end

  private

  attr_accessor :game
end
