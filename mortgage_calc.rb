# Mortgage_Calculator

def prompt(message)
  # escape characters used to colorize terminal o/p in green
  puts "\e[32m=> #{message}\e[0m"
end

# function to display message in red color in terminal
def red(message)
  "\e[31m$ #{message} \e[0m"
end

def obtain_user_input(apr_flag = nil)
  user_input = 0
  loop do
    user_input = gets.chomp
    if valid_input?(user_input, apr_flag)
      break
    else
      prompt("Invalid number. Enter again")
    end
  end
  user_input.to_f
end

def valid_input?(user_input, apr_flag = nil)
  if apr_flag
    user_input.to_f > 0 && user_input.to_f <= 100
  else
    # Regex key
    # ^ start of line, $ end of line
    # \d* any number of digits
    # +(\.\d{1,2})? optional 1 or 2 digits after decimal point
    user_input.match(/^\d+(\.\d{1,2})?$/)
  end
end

prompt("Welcome to the Mortgage Calculator")
prompt("-" * 35)
loop do
  prompt("Enter the loan amount (upto two decimals)")
  loan_amt = obtain_user_input

  prompt("Enter the Annual Percentage Rate (between 0 - 100 & upto 2 decimals)")
  apr = obtain_user_input('apr')

  prompt("Enter the duration of the loan in years (upto 2 decimals)")
  duration_years = obtain_user_input

  int_rate_monthly = (apr / 100) / 12
  duration_months = duration_years * 12

  compound_int_rate = (1 + int_rate_monthly)**duration_months
  monthly_payment = (loan_amt * (int_rate_monthly * compound_int_rate) /
                    (compound_int_rate - 1))
  total_interest = (monthly_payment * duration_months) - loan_amt

  prompt("Your fixed monthly loan payment: #{red(monthly_payment.round(2))}")
  prompt("Total interest paid at end of term: #{red(total_interest.round(2))}")

  prompt("Would you like to do another calculation?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt("Thankyou for using the mortgatge calculator.")
