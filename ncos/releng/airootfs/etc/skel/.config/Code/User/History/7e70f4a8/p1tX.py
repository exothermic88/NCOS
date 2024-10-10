def calculate_dot_product(vector1, vector2):
    """
    Calculate the dot product of two vectors.

    Args:
        vector1 (list): The first vector as a list of numbers.
        vector2 (list): The second vector as a list of numbers.

    Returns:
        float: The dot product of the two vectors.

    Raises:
        ValueError: If the vectors have different lengths.
    """
    if len(vector1) != len(vector2):
        raise ValueError("Vectors must have the same length")

    return sum(a * b for a, b in zip(vector1, vector2))

vector1 = [1, 2, 3]
vector2 = [4, 5, 6]

result = calculate_dot_product(vector1, vector2)
print(f"The dot product is: {result}")