import os
import random

print('Entrez "i" pour les instructions. ')

def clear(): return os.system('clear')

life=3
pts=0

xa=0
xa2=0
atq=0

x=0
xc=random.randint(0,119)
xm=random.randint(0,119)

while True:

    if x<0:
        x=0
    if x>118:
        x=118

    if x==xc:
        pts+=1
        xc=random.randint(0,119)
    if atq==1:
            xa=x+1
            xa2=x-1
    if x<xm:
        xm-=1
    else:
        xm+=1
    if atq==1 and (xm==xa or xm==xa2):
            xm=random.randint(0,119)
    if xm==x or xm==x-1 or xm==x+1:
        life-=1
        x=0
    if life==0:
        print('T MORT')
        print(f'TON SCORE : {pts}')
        quit()

    L=[]
    for i in range(119):
        if atq==1 and (i==xa or i==xa2):
            L.append('☼')
        elif i==x:
            L.append('☻')
        elif i==xc:
            L.append('₿')
        elif i==xm:
            L.append('☺')
        else:
            L.append('█')  

    for i in L:  
        print(i, end='')
    print(f'ARGENT : {pts} | VIES : {life} ')

    a=input()
    clear()
    
    if a=='d':
        atq=0
        x+=1
    elif a=='q':
        atq=0
        x-=1
    elif a=="0":
        atq=1
    elif a=="i":
        print("Vous êtes blanc, vous devez taper les noirs et ramasser du bitcoin.")
        print("d = droite | q = gauche | 0 = attaquer")