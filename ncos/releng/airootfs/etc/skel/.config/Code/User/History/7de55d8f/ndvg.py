print('hello john')

def calculate_euler():
    e = 0.0
    n = 1
    while True:
        term = 1 / n
        e += term
        if abs(term) < 1e-15: # Precision threshold
            break
        n += 1
    return round(e, 10)

# Example usage
result = calculate_euler()
print(f"Euler's number (e): {result}")

calculate_euler()