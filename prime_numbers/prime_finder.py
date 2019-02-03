import math

def is_prime(n):
    for i in range(2, int(1+math.sqrt(n))):
        if n % i == 0:
            return False
        
    return True

i = 1

try:
    while True:
        if is_prime(i):
            print(i)
        i += 1
except:
    print(f"Checked up to {i}")