def sum_of_integers():
    """
    Prompts the user to enter two integers and returns their sum.

    Raises:
        ValueError: If a floating-point number is provided or the input cannot be converted to an integer.

    Returns:
        int or None: The sum of the two integers if valid inputs are provided. 
        Returns None if an exception is raised.
    """
    try:
        a = input("Enter the first integer: ")
        b = input("Enter the second integer: ")
        
        if '.' in a or '.' in b:
            raise ValueError(f"Please enter an integer, floating point numbers are not allowed")

        a = int(a)
        b = int(b)

        return a + b
    
    except ValueError as e:
        print(f"Error: {e}")
        return None

sum = sum_of_integers()
if sum is not None:
    print("Sum:", sum)

