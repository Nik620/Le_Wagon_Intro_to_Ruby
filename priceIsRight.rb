# Price is Right minigame
# updated for continuous loops
# added easy, medium, and hard modes

p "Welcome to the 'Price is Right' Mini-Game\n"

# initialize variables
num_guesses = 0
game_play = true
game_num = 1
num_to_guess = 0
upr_limit = 10
p "Round #{game_num}"

# running gameplay
while game_play == true

  # game modes
  p "Choose Easy (E), Medium (M), or Hard (H) modes. Type (exit) to exit."
  response = gets.chomp.to_s.upcase!

  # response verificaiton
  until response == 'E' || response == 'M' || response == 'H' || response == 'EXIT'
    p "Input not recognized."
    p "Choose Easy (E), Medium (M), or Hard (H) modes. Type (exit) to exit."
    response = gets.chomp.to_s.upcase!
  end

  # game type check
  if response == 'E'
    upr_limit = 10
  elsif response == 'M'
    upr_limit = 25
  elsif response == 'H'
    upr_limit = 100
  else
    p "Thank you for playing!"
    game_play == false
    break
  end

  # game setup
  num_to_guess = rand(1..upr_limit)
  p "Guess a number from 1 to #{upr_limit}"
  user_guess = gets.chomp.to_i

  while user_guess != num_to_guess
    if user_guess < num_to_guess
      p "Incorrect: The number is higher."
    elsif user_guess > num_to_guess
      p "Incorrect: The number is lower."
    end
    p "Guess a number from 1 to #{upr_limit}"
    user_guess = gets.chomp.to_i
  end
  p "Correct!"

  # continue playing condition
  p "Do you wish to continue? (Type Yes/No)"
  response = gets.chomp.downcase!
  until response == 'yes' || response = 'no'
    p "Input not recognized."
    p "Do you wish to continue? (Type Yes/No)"
    response = gets.chomp.downcase!
  end
  
  if response == 'no'
    p "Thank you for playing!"
    game_play == false
    break
  end

  # game reset
  game_num += 1
  p "Round #{game_num}"
end
