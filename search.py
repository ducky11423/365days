import os

def search(path, term):
    try:
        dir = os.listdir(path)
        for f in dir:
            if os.path.isdir(path + f):
                search(path + f + "/", term)
            else:
                if term in f:
                    print(path + f)
    except:
        pass

drive = input("drive: ")
search_term = input("search: ")
path = drive + ":/"
print("Searching")

search(path, search_term)