n = int(input("Enter the number: "))

add_perst = 0

while n > 9:
    parts = []
    temp = n
    while temp > 0:
        next_part = int(temp - int(temp/10) * 10)
        parts.append(next_part)
        temp -= next_part
        temp /= 10

    n = 0
    for i in parts:
        n += i
    
    add_perst += 1
print(add_perst)