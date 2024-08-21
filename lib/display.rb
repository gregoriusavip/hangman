# frozen_string_literal: true

# Display prompts/informations to the terminal
class Display
  def self.guess_prompt(guess_limit)
    puts "You have #{guess_limit} remaining guess(es)"
  end

  def self.chosen_letters(correct_letters, incorrect_letters)
    puts "Correct chosen letters: #{correct_letters.to_a}"
    puts "Incorrect chosen letters: #{incorrect_letters.to_a}"
  end

  def self.hangman_progress(progress)
    puts progress.join(' ')
  end

  def self.announce_win(answer)
    puts 'Congratulations! You have found the answer'
    puts "The secret word is: #{answer}"
  end

  def self.announce_lose(answer)
    puts 'You ran out of guess!'
    puts "The secret word is: #{answer}"
  end
end
