print('hello john')

def calculate_euler():
    n = 50 # Number of terms in the Taylor series
    e = 0
    
    for k in range(n):
        term = 1 / factorial(k)
        e += term
    
    return round(e, 5)

import math

def factorial(n):
    if n == 0 or n == 1:
        return 1
    else:
        return n * factorial(n-1)

# Test the function
result = calculate_euler()
print(f"Euler's number: {result}")

calculate_euler()