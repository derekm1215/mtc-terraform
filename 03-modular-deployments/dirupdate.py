import os

# get the directory list
def dirlist():
    dirs = os.listdir("/home/ubuntu/environment/mtc-terraform/03-modular-deployments")
    numlist = []
    for i in dirs:
        num = i.split('-')[0]
        if num.isnumeric():
            numlist.append(int(i.split('-')[0]))
            #print(str(int(num)+1).zfill(2))
    numlist.sort()
    newlist = []
    for i,n in enumerate(numlist):
        newlist.append(n)
        if n == numlist[i-1]:
            dupe = n
            print(dupe)
        else:
            print(f"{n}:{numlist[i-1]}-no dupe")
    for i in newlist:
        if i > dupe:
            print(i)
    print(newlist)
dirlist()

