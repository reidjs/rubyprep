# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

$myNum = rand(10)+1
$guesses = 0
def play_game
  playerGuess = gets.chomp.to_i
  $guesses += 1
  if playerGuess < $myNum
    puts "Too low"
    play_game
  elsif playerGuess > $myNum
    puts "Too high"
    play_game
  else
    puts "You win! It took you #{$guesses} guesses to get #{$myNum}"
  end
end

def shuffler
  # filename = gets.chomp
  filename = "testfile"
  arr = []
  File.foreach(filename) do |l|
    arr << l
  end
  arr.shuffle!
  shuffled_filename = "#{filename}-shuffled"
  File.write(shuffled_filename, "")
  arr.each do |l|
    File.write(shuffled_filename, l, File.size(shuffled_filename), mode: 'a')
  end
end
shuffler
