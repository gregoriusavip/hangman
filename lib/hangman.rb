# frozen_string_literal: true

require_relative('game')
require_relative('display')

# Create instances of a hangman game
class Hangman < Game
  def initialize(guess_limit, word = Hangman.random_word.split(''), correct_letters = Set[], incorrect_letters = Set[])
    super()
    self.secret_word = word
    self.guess_limit = guess_limit
    self.correct_letters = correct_letters
    self.incorrect_letters = incorrect_letters
    self.progress = build_progress
  end

  def self.load(yaml_file)
    vars = from_yaml(yaml_file)
    new(vars[:guess_limit], vars[:secret_word], vars[:correct_letters], vars[:incorrect_letters])
  end

  private

  def save
    to_yaml(secret_word:, guess_limit:, correct_letters:, incorrect_letters:)
  end

  def play_game
    Display.hangman_prompt_loop(guess_limit, correct_letters, incorrect_letters, progress)
    input = gets.chomp.downcase
    input.eql?('save') ? save_and_quit : guess(input)
  end

  def guess(letter)
    return nil unless validate_guess(letter)

    update_progress(letter)
  end

  def win?
    return false unless secret_word.eql?(progress)

    Display.announce_win(secret_word.join(''))
    true
  end

  def game_over?
    return false unless guess_limit.eql?(0)

    Display.announce_lose(secret_word.join(''))
    true
  end

  def build_progress
    secret_word.map { |char| correct_letters.include?(char) ? char : '_' }
  end

  def validate_guess(letter)
    letter.match?(/^[[:alpha:]]$/) && !(correct_letters + incorrect_letters).include?(letter)
  end

  def update_progress(letter)
    incorrect = true
    secret_word.each_with_index do |l, i|
      incorrect = modify_progress_at(l, i) if l.eql?(letter)
    end
    guess_incorrect(letter) if incorrect
  end

  def modify_progress_at(letter, index)
    progress[index] = letter
    correct_letters << letter
    false
  end

  def guess_incorrect(letter)
    incorrect_letters << letter
    self.guess_limit -= 1
  end

  attr_accessor :guess_limit, :correct_letters, :incorrect_letters, :progress, :secret_word, :input
end
