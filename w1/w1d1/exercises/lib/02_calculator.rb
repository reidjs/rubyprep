def add(a,b)
  a+b
end
def subtract(a,b)
  a-b
end
def sum(ar)
  ar.inject(0){|sum, element| sum+= element}
end
def multiply(*args)
  args.inject{|product, element| product *= element}
end
def power(base, pow)
  base**pow
end
def factorial(n)
  if n == 0
    return n
  end 
  f = 1
  while n > 1
    f *= n
    n -= 1
  end
  f
end
