# frozen_string_literal: true

# Create instances of a hangman game
class Hangman
  def intialize(secret_word, guess_limit, correct_letters = Set[], incorrect_letters = Set[])
    self.secret_word = secret_word
    self.guess_limit = guess_limit
    self.correct_letters = correct_letters
    self.incorrect_letters = incorrect_letters
    self.progress = build_progress
  end

  private

  def build_progress
    secret_word.split('').map { |char| correct_letters.include?(char) ? char : '_' }
  end

  def validate_guess(letter)
    !(correct_letters + incorrect_letters).include?(letter)
  end

  attr_accessor :secret_word, :guess_limit, :correct_letters, :incorrect_letters, :progress
end
