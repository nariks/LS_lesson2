GAME_RULES = { "r" => { "name"   => "Rock",
                        "wins"   => %w(s l),
                        "action" => %w(crushes crushes) },
               "s" => { "name"   => "Scissors",
                        "wins"   => %w(p l),
                        "action" => %w(cuts decapacitates) },
               "p" => { "name"   => "Paper",
                        "wins"   => %w(r sp),
                        "action" => %w(covers disproves) },
               "l" => { "name"   => "Lizard",
                        "wins"   => %w(p sp),
                        "action" => %w(eats poisons) },
               "sp" => { "name"   => "Spock",
                         "wins"   => %w(r s),
                         "action" => %w(vaporizes smashes) } }

def prompt(message)
  puts "\e[32m=> #{message}\e[0m"
end

def valid_choice?(input)
  input.match(/^([rpsl]|(sp))$/)
end

def return_winner(choice)
  if choice['Player'] == choice['Computer']
    'Tie'
  elsif GAME_RULES[choice['Player']]["wins"].include?(choice['Computer'])
    'Player'
  else
    'Computer'
  end
end

def return_loser(winner)
  winner == "Player" ? "Computer" : "Player"
end

# loser_index is used in display_win_rule method to obtain winning action word
def return_loser_index(winner, choice)
  loser = return_loser(winner)
  GAME_RULES[choice[winner]]["wins"].index(choice[loser])
end

def display_win_rule(winner, choice)
  wins_index = return_loser_index(winner, choice)
  loser = return_loser(winner)
  action_rule = GAME_RULES[choice[winner]]["action"][wins_index]
  prompt("#{GAME_RULES[choice[winner]]['name']} #{action_rule} " \
         "#{GAME_RULES[choice[loser]]['name']}")
end

def display_winner(winner, choice)
  win_result = (winner == "Tie" ? "Tie Game" : "#{winner} wins !!!")
  prompt("Player chose #{GAME_RULES[choice['Player']]['name']} and " \
         "Computer chose #{GAME_RULES[choice['Computer']]['name']}.")
  display_win_rule(winner, choice) unless winner == "Tie"
  prompt(win_result)
end

def validate_input
  loop do
    player_input = gets.chomp.downcase
    return player_input if valid_choice?(player_input)
    prompt("Invalid Entry. Choose from r,p,s,l,sp")
  end
end

def display_score(score)
  puts("\nSCORE BOARD")
  puts("=" * 20)
  printf("%-15s: %3d\n", 'Player Score', score['Player'])
  printf("%-15s: %3d\n", 'Computer Score', score['Computer'])
  printf("%-15s: %3d\n\n", 'Tie Score', score['Tie'])
end

def display_selection_choices
  prompt("Valid choices:")
  GAME_RULES.each do |key, value|
    printf("   Enter %s for %-10s\n", key, value["name"])
  end
end

# Tracks scores after each game is played
continue = true # tracks if player wants to continue playing.

system("clear")
prompt("Welcome to the game of Rock Paper Scissors Lizard Spock")
prompt("\e[31mFirst to reach 5 points wins\e[0m")
display_selection_choices

while continue
  score = { "Player"   => 0,
            "Computer" => 0,
            "Tie"      => 0 }

  # Stores  player's and computer's choice
  choices = { "Player"   => "",
              "Computer" => "" }

  loop do
    prompt("Enter your choice")
    choices["Player"] = validate_input
    choices["Computer"] = GAME_RULES.keys.sample

    winner = return_winner(choices)
    display_winner(winner, choices)

    score[winner] += 1
    display_score(score)

    max_score = [score["Player"], score["Computer"]].max
    break if max_score == 5
  end

  series_winner = score["Player"] > score["Computer"] ? "Player" : "Computer"
  prompt("#{series_winner} wins series !")

  prompt("Would you like to play again (y to continue, any key to quit)")
  continue = gets.chomp.downcase.start_with?("y")
end
prompt("Game over. Thanks for playing")
