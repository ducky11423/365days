def print_towers():
    print()

    # print all the disc numbers
    for i in range(n_discs):
        list_index = n_discs - i - 1
        print_string = ""
        for tower in towers:
            print_string += " "
            if len(tower) > list_index:
                print_string += str(tower[list_index])
            else:
                print_string += " "
            print_string += " "
        print(print_string  )
    
    # print a line of underscores 1 wider than the towers
    print("---------")
    print(" 1  2  3 ")    

def get_tower_selection(input_text):
    while True:
        try:
            inp = int(input(input_text))

            if inp < 1 or inp > 3:
                raise ValueError()
            
            return(inp)
        except KeyboardInterrupt:
            quit() 
        except:
            print("Invalid input")


towers = []

for i in range(3):
    towers.append([])

n_discs = 4

try:
    n_discs = int(input("Enter the number of discs: "))
except KeyboardInterrupt:
        quit() 
except:
    pass

print(f"Playing tower of hanoi with {n_discs} discs.")

for i in reversed(range(n_discs)):
    towers[0].append(i + 1)

n_moves = 0

while not len(towers[2]) == n_discs:
    print_towers()

    move_from = get_tower_selection("What tower would you like to move from: ") - 1

    if len(towers[move_from]) == 0:
        print("That tower has no discs.")
        continue

    move_to = get_tower_selection("What tower would you like to move to: ") - 1

    if move_to == move_from:
        continue

    if len(towers[move_to]) != 0 and towers[move_from][-1] > towers[move_to][-1]:
        print("You cannot place a larger disc on top of a smaller disc.")
        continue

    towers[move_to].append(towers[move_from].pop())
    n_moves += 1

print(f"Congratulations, you completed the puzzle in {n_moves} moves!")