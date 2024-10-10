def euler(n):
    """
    Calculate the nth Euler number
    
    Args:
        n (int): The position of the Euler number to calculate
    
    Returns:
        int: The nth Euler number
    """
    if n == 0:
        return 1
    else:
        return 2 * euler(n-1) - euler(n-2)

# Test the function
print(f"Euler(5) = {eulr(5)}")
