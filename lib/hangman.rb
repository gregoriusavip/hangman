# frozen_string_literal: true

# Create instances of a hangman game
class Hangman
  def intialize(secret_word, guess_limit, correct_letters = Set[], incorrect_letters = Set[])
    self.secret_word = secret_word.split('')
    self.guess_limit = guess_limit
    self.correct_letters = correct_letters
    self.incorrect_letters = incorrect_letters
    self.progress = build_progress
  end

  def guess(letter)
    return nil unless validate_guess(letter)

    update_progress(letter)
  end

  private

  def build_progress
    secret_word.map { |char| correct_letters.include?(char) ? char : '_' }
  end

  def validate_guess(letter)
    letter.match?(/^[[:alpha:]]$/) && !(correct_letters + incorrect_letters).include?(letter)
  end

  def update_progress(letter)
    secret_word.each_with_index do |l, i|
      l.eql?(letter) ? modify_progress_at(l, i) : incorrect_letters << letter
    end
    self.guess_limit -= 1
  end

  def modify_progress_at(letter, index)
    progress[index] = letter
    correct_letters << letter
  end

  attr_accessor :secret_word, :guess_limit, :correct_letters, :incorrect_letters, :progress
end
