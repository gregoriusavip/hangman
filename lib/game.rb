# frozen_string_literal: true

require 'fileutils'
require 'yaml'

# Manage game state, save and load game
class Game
  DICTIONARY = 'google-10000-english'

  def self.random_word
    return unless File.exist? DICTIONARY

    File.open(DICTIONARY).each.filter do |word|
      word.strip.length.between?(5, 12)
    end.sample.chomp
  end

  def loop
    until win? || game_over?
      break if save_and_quit

      play_game
    end
  end

  private

  def save_and_quit
    Display.saving_prompt
    gets.chomp.eql?('1') ? save : false
  end

  def to_yaml(**args)
    FileUtils.mkdir_p 'saves'
    File.write('./saves/save.yml', YAML.dump(args))
  end
end
