VALID_CHOICES = {'r' => 'Rock',
                 's' => 'Scissors',
                 'p' => 'Paper',
                 'l' => 'Lizard',
                 'S' => 'Spock' }

WINNING_COMBINATIONS = { 'r' => %w(s l),
                         's' => %w(p l),
                         'p' => %w(r S),
                         'l' => %w(p S),
                         'S' => %w(r s) }


def prompt(message)
  puts "\e[32m=> #{message}\e[0m"
end

def winner?(first, second)
  WINNING_COMBINATIONS[first].include?(second)
end

def valid_input?(input)
  input.match(/^[rpslS]$/)
end

def track_score(result)
  $score[result] += 1
  
end

def select_winner(player_choice, computer_choice)
  if winner?(player_choice, computer_choice)
    'Player'
  elsif winner?(computer_choice, player_choice)
    'Computer'
  else
    'Tie'
  end
  end

def validate_input(player_input)
  loop do
    if valid_input?(player_input)
      break
    else
      prompt("Invalid Entry. Try again")
      player_input = gets.chomp
    end
  end
  player_input
end

def display_score(score)
  puts 11111
  printf("%20s: %3d\n",'Player Score', score['Player'])
  printf("%20s: %3d\n",'Computer Score', score['Computer'])
  printf("%20s: %3d\n",'Tie Score', score['Tie'])
end

prompt("Welcome to rock paper scissors lizard Spock game")
score = { 'Player'   => 0,
          'Computer' => 0,
          'Tie'      => 0 }
winner = ""

loop do
  prompt("Enter your choice: r for rock,
                             p for paper,
                             s for scissors,
                             l for lizard,
                             S for Spock")

  player_choice = validate_input(gets.chomp)
  computer_choice = VALID_CHOICES.keys.sample
  prompt("Player's choice is #{VALID_CHOICES[player_choice]}")
  prompt("Computer's choice is #{VALID_CHOICES[computer_choice]}")

  winner = select_winner(player_choice, computer_choice)
  puts(winner == 'Tie' ? "Tie Game" : "#{winner} wins !!!")

  score[winner] += 1
  display_score(score)
  max_score = score.values.max
  if max_score == 5
    prompt("Game over #{score.key(max_score)} wins !")
    break
  else
    prompt("Would you like to play again (y/n)")
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end
