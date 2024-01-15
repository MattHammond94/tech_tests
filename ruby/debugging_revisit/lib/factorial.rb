def factorial(n)
  product = 1

  while n > 1
    product *= n
    n -= 1

    puts "Product: #{product}"
    puts "number: #{n}"
  end

  product
end

p factorial(8)