def uppercase_list(list):
    """
    Prints each string from a list in uppercase.

    Args:
        list (List[str]): A list of strings to be printed in uppercase.
    """
    for item in list:
        print(item.upper())
    
    
animals = ['tiger', 'elephant', 'monkey', 'zebra', 'panther']

uppercase_list(animals)