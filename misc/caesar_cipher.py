input_string = input("Enter the text you want to encrypt: ").lower()
shift = int(input("Enter the shift: "))

encrypt = "".join([ chr((ord(i) - 97 + shift) % 26 + 97) for i in input_string.lower()])
print(f"Encrypted string: {encrypt}")