# frozen_string_literal: true

require 'fileutils'
require 'yaml'

# Manage game state, save and load game
class Game
  DICTIONARY = 'google-10000-english'

  def initialize
    @exit_flag = false
  end

  def self.random_word
    return unless File.exist? DICTIONARY

    File.open(DICTIONARY).each.filter do |word|
      word.strip.length.between?(5, 12)
    end.sample.chomp
  end

  def loop
    play_game until @exit_flag || win? || game_over?
  end

  def self.from_yaml(yaml_file)
    YAML.load_file(yaml_file, permitted_classes: [Set, Symbol])
  end

  private

  def save_and_quit
    save
    @exit_flag = true
  end

  def to_yaml(**args)
    FileUtils.mkdir_p 'saves'
    File.write('./saves/save.yml', YAML.dump(args))
  end
end
