# frozen_string_literal: true

require_relative('game')

# Create instances of a hangman game
class Hangman < Game
  attr_reader :guess_limit, :correct_letters, :incorrect_letters, :progress

  def initialize(guess_limit, word = Hangman.random_word, correct_letters = Set[], incorrect_letters = Set[]) # rubocop:disable Lint/MissingSuper
    self.secret_word = word.split('')
    self.guess_limit = guess_limit
    self.correct_letters = correct_letters
    self.incorrect_letters = incorrect_letters
    self.progress = build_progress
  end

  def loop
    play_game until win? || game_over?
  end

  private

  def play_game
    Display.hangman_prompt_loop(guess_limit, correct_letters, incorrect_letters, progress)
    guess(gets.chomp)
  end

  def guess(letter)
    return nil unless validate_guess(letter.downcase)

    update_progress(letter.downcase)
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

  attr_accessor :secret_word
  attr_writer :guess_limit, :correct_letters, :incorrect_letters, :progress
end
