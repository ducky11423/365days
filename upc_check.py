# https://www.reddit.com/r/dailyprogrammer/comments/a72sdj/20181217_challenge_370_easy_upc_check_digits/

code = input("Enter the UPC code: ").strip() # Get the UPC code
code = (11 - len(code)) * "0" + code # Add leading zeros to the code if required

odd_sum = 0 # odd ordinal positions of the code
even_sum = 0 

for i in range(11):
    if i % 2 == 0:
        odd_sum += int(code[i])
    else:
        even_sum += int(code[i])

sum = odd_sum * 3 + even_sum
m = sum % 10

check_digit = 10 - m
if m == 0:
    check_digit = 0

print(f"Check digit: {check_digit}")