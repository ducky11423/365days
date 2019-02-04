import math
import time

primes = []

n_check = 1000000

def is_prime(n):
    for i in range(2, math.floor(math.sqrt(n)) + 1):
        if n % i == 0:
            return False
        
    return True

# must be run for every number from 2 sequentially.
def is_prime_seq(n):
    sqrt = math.sqrt(n) + math.sqrt(n_check)
    for i in primes:
        if i > sqrt:
            return True
        if n % i == 0:
            return False
    
    primes.append(n)
    return True

i = 2
n_primes = 0
start_time = time.time()

while i < n_check:
    if is_prime_seq(i):
        n_primes += 1
    i += 1

print(f"Found {n_primes} primes in {time.time() - start_time}, checking for primes up to {n_check}, using the list of primes as possible divisors.")

start_time = time.time()
i = 2
n_primes = 0
start_time = time.time()

while i < n_check:
    if is_prime(i):
        n_primes += 1
    i += 1

print(f"Found {n_primes} primes in {time.time() - start_time}, checking for primes up to {n_check}.")