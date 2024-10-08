def count_vowels(word):
    """
    Count no of vowels in a word.
    
    Args:
        word (str): Test word
        
    Returns:
        int: count of vowels in given word.
    """
    
    vowels = ["a","e","i","o","u"]
    count = 0
    
    for letter in word.lower():
        if letter in vowels:
            count += 1
    
    return count

print(count_vowels("HELLO")) 
print(count_vowels("HeLLo"))
print(count_vowels("aEioU1241234aeiou")) 
print(count_vowels("a")) 
print(count_vowels("z")) 
print(count_vowels("bcdfg")) 

    
