# MOONRACE GAME
# First player to reach the end of the
# board wins. Added custom initialization.

# INITIALIZATION
# initializing variables
EARTH = '🌏 '
MOON = '🌕'
ROCKET = '🚀 '
SPACE = '  '
WARP = '🌌 '
ALIEN = '🛸 '
PLAYER = '👨‍🚀 '
BOT = '🤖 '
print `clear`
modes = {
  'E' => {length: 10, warps: 1, aliens: 1, adjust: 1},
  'M' => {length: 20, warps: 2, aliens: 2, adjust: 2},
  'H' => {length: 40, warps: 4, aliens: 4, adjust: 4},
  'C' => {}
}

# custom response function
def num_check(number, min, max)
  if number >= min && number <= max
    return number
  else
    puts "Your response must be between #{min} and #{max}."
    number = num_check(gets.chomp.to_i, min, max)
    return number
  end
end

# warp and alien position generator
def position_generator(pos1, pos2, length)
  # generate a position away from earth and moon
  position = rand(1..length - 1)
  if pos1.include? position or pos2.include? position
    position = position_generator(pos1, pos2, length)
  end
  return position
end

# opponent setup
def scroll_names(names)
  3.times do
    names.each do |name|
      print name + "\r"
      $stdout.flush
      sleep(0.2)
    end
  end
end

# board setup for each turn
def set_board(position, length, w_pos, w_mov, a_pos, a_mov)
  board = []
  # space setup
  for i in 0..length
    board.push(SPACE)
  end
  # moon and earth setup
  board[0] = EARTH
  board[length] = MOON
  # check for warp and alien positions
  w_pos.each {|i| board[i] = WARP}
  a_pos.each {|i| board[i] = ALIEN}
  # collision with warp or alien
  if board[position] == WARP
    puts "Warp +#{w_mov} spaces forward."
    position += w_mov
  elsif board[position] == ALIEN
    puts "Alien pushes back -#{a_mov}."
    position -= a_mov
  end
  position = 0 if position < 0
  position = length + 1 if position >= length
  # setting position of emoji
  if position < 0
    position = 0
    board[position] = ROCKET
  elsif position >= length
    position = length + 1
    board[position] = ROCKET
    position = length
  else
    board[position] = ROCKET
  end
  board.each {|i| print i}
  puts ''
  return position
end

# dice roll
def dice
  number = rand(1..6)
  numbers = [1,2,3,4,5,6]
  3.times do
    numbers.each do |num|
      print "#{num}\r"
      $stdout.flush
      sleep(0.1)
    end
  end
  return number
end

# turn operations
def turn(name, position)
  puts "#{name} your turn..."
  puts 'press enter to roll the dice'
  gets.chomp
  number = dice
  position += number
  puts "#{name} rolled a #{number}"
  return position
end

# GAMEPLAY
# title screen
puts ''
puts '       Le Wagon Moon Race'
puts '   First Rocket to the moon wins'
puts ''
puts ''

# game mode setup
puts 'Choose Easy (E), Medium (M),'
puts 'Hard (H), or Custom (C) modes.'
response = gets.chomp.to_s.upcase!

until response == 'E' || response == 'M' || response == 'H' || response == 'C'
  puts 'Input not recognized.'
  puts 'Choose Easy (E), Medium (M), Hard (H), or Custom (C) modes.'
  response = gets.chomp.to_s.upcase!
end

# custom mode setup
if response == 'C'
  puts "What length would you like (10-50)?"
  response2 = num_check(gets.chomp.to_i, 10, 50)
  modes['C'][:length] = response2
  puts "Warps desired (1-5):"
  response2 = num_check(gets.chomp.to_i, 1, 5)
  modes['C'][:warps] = response2
  puts "Aliens desired (1-5):"
  response2 = num_check(gets.chomp.to_i, 1, 5)
  modes['C'][:aliens] = response2
  puts "Warp/Alien adjustment distance (1-5):"
  response2 = num_check(gets.chomp.to_i, 1, 5)
  modes['C'][:adjust] = response2
end

# game setup finalization
winning_number = modes[response][:length]
warp_qty = modes[response][:warps]
warp_move = modes[response][:adjust]
alien_qty = modes[response][:aliens]
alien_move = modes[response][:adjust]
warp_pos = []
alien_pos = []

for i in 0..(warp_qty - 1)
  warp_pos.push(position_generator(warp_pos, alien_pos, winning_number))
end
for i in 0..(alien_qty - 1)
  alien_pos.push(position_generator(alien_pos, warp_pos, winning_number))
end

# title screen
puts ''
puts "#{winning_number} Spaces to Victory"
puts ''
puts 'Press enter to begin'
gets.chomp
print `clear`

# name input & opponent setup
puts "What's your name?"
user = gets.chomp + PLAYER
names = ['Viktor', '101101', 'Ivanov', '010100', 'Hector', '000101', 'Charli', '100011']
puts "Finding your opponent..."
scroll_names(names)
computer = names[rand(0...names.length)] + BOT
puts "Your opponent is #{computer}"

# board initialization
puts ''
puts user
user_position = 0
set_board(user_position, winning_number, warp_pos, warp_move, alien_pos, alien_move)
puts ''
puts 'versus'
puts ''
puts computer
computer_position = 0
set_board(user_position, winning_number, warp_pos, warp_move, alien_pos, alien_move)
puts ''
puts "press enter to continue"
gets.chomp
print `clear`

# game loop
until user_position >= winning_number || computer_position >= winning_number
  # User's turn
  user_position = turn(user, user_position)
  user_position = set_board(user_position, winning_number, warp_pos, warp_move, alien_pos, alien_move)
  puts "The new position is #{user_position}"
  puts ''
  # Computer's turn
  computer_position = turn(computer, computer_position)
  computer_position = set_board(computer_position, winning_number, warp_pos, warp_move, alien_pos, alien_move)
  puts "The new position is #{computer_position}"
  puts ''
  # clear screen anc continue
  puts ''
  puts "press enter to continue"
  gets.chomp
  print `clear`
end

# display the result
if user_position > computer_position
  puts "#{user} won!"
elsif user_position == computer_position
  puts "#{user} & #{computer} tied!"
else
  puts "#{computer} won... sorry you lost"
end
