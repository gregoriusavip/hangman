# frozen_string_literal: true

# Manage game state, save and load game
class Game
  DICTIONARY = 'google-10000-english'

  def self.random_word
    return unless File.exist? DICTIONARY

    File.open(DICTIONARY).each.filter do |word|
      word.strip.length.between?(5, 12)
    end.sample.strip
  end
end
