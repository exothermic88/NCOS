print('hello john')
import math
def euler_totient(n):
    result = n
    
    p = 2
    while p * p <= n:
        if n % p == 0:
            while n % p == 0:
                n //= p
            result -= result // p
        p += 1
    
    if n > 1:
        result -= result // n
    
    return result

# Example usage
print(euler_totient(10)) # Output: 4
print(euler_totient(12)) # Output: 4
print(euler_totient(15)) # Output: 8
