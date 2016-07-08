Kernet.puts("Enter first number")
number1 = Kernel.gets().chomp()
Kernet.puts("Enter second number")
number2 = Kernel.gets().chomp()
Kernel.puts("Enter operation to be performed: +-*/")
operation = Kernel.gets().chomp()
case operation
when '+'
  result = mumber1 + number2
when '-'
  result = number1 - number2
when '*'
  result = number1 * number2
when '/'
  result = number1 / number2
else 
  Kerner.puts("Invalid operator")
end
Kernel.puts("The result of #{number1} #{operation} #{number2} is #{result}"
