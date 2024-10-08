def print_numbers(nums):
    """
    Prints numbers from 1 to a specified number and labels them as 'Even' or 'Odd'.

    This function iterates through numbers starting from 1 up to the value of `nums`, 
    and prints each number followed by whether the number is 'Even' or 'Odd'. 

    Args:
        nums (int): The upper limit up to which numbers will be printed.
    """
    for num in range(1, nums+1):
        print(num, "Even" if num%2 ==0 else "Odd" )
        
        
print_numbers(20)