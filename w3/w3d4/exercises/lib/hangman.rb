class Hangman
  attr_reader :guesser, :referee, :board, :guessed_letters
  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @guessed_letters = []
  end
  def setup
    secret_word_length = @referee.send(:pick_secret_word)
    @guesser.send(:register_secret_length, secret_word_length)
    @board = "_"*secret_word_length
  end
  def take_turn
    guess = @guesser.send(:guess)
    @guessed_letters << guess
    correct_indices = @referee.send(:check_guess, guess)
    self.update_board
    @guesser.send(:handle_response)
  end
  def update_board
    @guessed_letters
  end
end

class HumanPlayer
end

class ComputerPlayer
  attr_reader :dictionary, :secret_word, :secret_word_length
  def initialize(dictionary)
    @dictionary = dictionary
  end
  def register_secret_length(length)
    @secret_word_length = length
  end
  def pick_secret_word
    @secret_word = @dictionary[rand(@dictionary.length)]
    @secret_word.length
  end
  def check_guess(letter)
    correct_indices = []
    @secret_word.chars.each_index do |i|
      if @secret_word[i] == letter
        correct_indices << i
      end
    end
    correct_indices
  end
  def guess(board)
    # ("a".."z").to_a.sample #random letter
    #determine the most common letter and guess that one
    l = {}
    candidate_words.each do |w|
      w.chars.each do |c|
        l[c].nil? ? l[c] = 1  : l[c] += 1
      end
    end
    max_val = 0
    max_key = "a"
    l.keys.each do |k|
      if l[k] > max_val && !board.include?(k)
        max_val = l[k]
        max_key = k
      end
    end
    max_key
  end
  def candidate_words
    @dictionary.select{|w| w.length == @secret_word_length}
  end
  #Only select words with the letter at the specified indices
  def handle_response(letter, indices)
    @dictionary.select! do |w|
      word_still_valid?(w,letter,indices)
    end
  end
  def word_still_valid?(word, letter, indices)
    word.chars.each_index do |i|
      #example: rear if there's only 1 'r' this would exclude the last 'r'
      if word[i] == letter && !indices.include?(i)
        return false
      elsif indices.include?(i) && word[i] != letter
        return false
      end
    end
    true
  end
end
