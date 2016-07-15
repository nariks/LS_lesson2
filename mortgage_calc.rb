# Mortgage_Calculator

def prompt(message)
  puts "=> #{message}"
end

def obtain_user_input
  user_input = 0
  loop do
    user_input = gets.chomp
    if valid_input?(user_input)
      break
    else
      prompt("Invalid number. Enter again")
    end
  end
  user_input.to_f
end

def valid_input?(user_input)
  # Regex key
  # \d* 
  user_input.match(/^\d*\.?\d*$/)
end

prompt("Welcome to the Mortgage Calculator")
prompt("Enter the loan amount")
loan_amt = obtain_user_input

prompt("Enter the Annual Percentage Rate (APR)")
apr = obtain_user_input

prompt("Enter the duration of the loan in years")
duration_years = obtain_user_input

int_rate_monthly = (apr / 100) / 12
duration_months = duration_years * 12

compound_int_rate = (1 + int_rate_monthly)**duration_months
fixed_monthly_payment = loan_amt * (int_rate_monthly * compound_int_rate) /
                        (compound_int_rate - 1)
prompt("Your monthly loan payment is $ #{fixed_monthly_payment}")
