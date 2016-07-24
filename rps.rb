VALID_CHOICES = { "r" => 'Rock',
                  "s" => 'Scissors',
                  "p" => 'Paper',
                  "l" => 'Lizard',
                  "S" => 'Spock' }

WIN_COMBINATIONS = { "r" => %w(s l), #{ wins => %w(s l), 
                                     #action => %w(crushes crushes)
                     "s" => %w(p l),
                     "p" => %w(r S),
                     "l" => %w(p S),
                     "S" => %w(r s) }

#RULES = { "rs" => "crushes"
#         "rl" => "lizard"

def prompt(message)
  puts "\e[32m=> #{message}\e[0m"
end

def valid_choice?(input)
  input.match(/^[rpslS]$/)
end

def valid_continue?(input)
  input.match(/^[yn]$/)
end

def select_winner(choice)
  if choice['Player'] == choice['Computer']
    'Tie'
  elsif WIN_COMBINATIONS[choice['Player']].include?(choice['Computer'])
    'Player'
  else
    'Computer'
  end
end

def display_winner(winner, choice)
  win_result = (winner == "Tie" ? "Tie Game" : "#{winner} wins !!!")
  prompt("Player chose #{VALID_CHOICES[choice["Player"]]} and " \
         "Computer chose #{VALID_CHOICES[choice["Computer"]]} " \
         "===> #{win_result}")
end

def validate_input(player_input)
  loop do
    return player_input if valid_choice?(player_input)
    prompt("Invalid Entry. Try again")
    player_input = gets.chomp
  end
end

def display_score(score)
  puts("\nSCORE BOARD")
  puts("=" * 20)
  printf("%-15s: %3d\n", 'Player Score', score['Player'])
  printf("%-15s: %3d\n", 'Computer Score', score['Computer'])
  printf("%-15s: %3d\n\n", 'Tie Score', score['Tie'])
end

def display_choices
  prompt("Valid choices:")
  VALID_CHOICES.each do |key, value|
    printf("   Enter %s for %-10s\n", key, value)
  end
end

# Tracks scores after each game is played
score = { "Player"   => 0,
          "Computer" => 0,
          "Tie"      => 0 }

# Stores  player's and computer's choice
choices = { "Player"   => "",
            "Computer" => "" }

system("clear")
prompt("Welcome to the game of Rock Paper Scissors Lizard Spock")
prompt("First to reach 5 points wins")
display_choices

loop do
  prompt("Enter your choice")
  choices["Player"] = validate_input(gets.chomp)
  choices["Computer"] = VALID_CHOICES.keys.sample
  winner = select_winner(choices)
  display_winner(winner, choices)

  score[winner] += 1
  display_score(score)

  max_score = [score["Player"],score["Computer"]].max
  if max_score == 5
    series_winner = score["Player"] > score["Computer"] ? "Player" : "Computer"
    prompt("#{series_winner} wins series !")
    break
  else
    prompt("Would you like to play again (y to continue, any key to quit)")
    answer = gets.chomp
    break unless answer.downcase.start_with?("y")
  end
end
prompt("Game over. Thanks for playing")
