import os
import msvcrt
import random

def clear(): return os.system('cls')
clear()
print('Tapez "i" pour avoir les instructions')
c=0
v=3

posj=[0,0]
posc=[random.randint(0,79),random.randint(0,19)]
posn=[random.randint(0,79),random.randint(0,19)]
posn2=[random.randint(0,79),random.randint(0,19)]
n=0
n2=0

while True:

	if posj[0]<0: #déplacement j
		posj[0]=0
	if posj[0]>79:
		posj[0]=79
	if posj[1]<0:
		posj[1]=0
	if posj[1]>19:
		posj[1]=19

	if posj==posc: #detec coin
		posc=[random.randint(0,79),random.randint(0,19)]
		c+=1

	if n==0: #délacement n
		n+=1
	elif n==1:
		if abs(posj[0]-posn[0])<abs(posj[1]-posn[1]):
			if posj[1]<posn[1]:
				posn[1]-=1
			else:
				posn[1]+=1
		else:
			if posj[0]<posn[0]:
				posn[0]-=1
			else:
				posn[0]+=1
		n+=1
	elif n==2:
		if abs(posj[0]-posn[0])<abs(posj[1]-posn[1]):
			if posj[1]<posn[1]:
				posn[1]-=1
			else:
				posn[1]+=1
		else:
			if posj[0]<posn[0]:
				posn[0]-=1
			else:
				posn[0]+=1
		n=0

	#déplacement n2
	if n2==0:  
		n2+=1
	else:
		if abs(posj[0]-posn2[0])<abs(posj[1]-posn2[1]):
			if posj[1]<posn2[1]:
				posn2[1]-=1
			else:
				posn2[1]+=1
		else:
			if posj[0]<posn2[0]:
				posn2[0]-=1
			else:
				posn2[0]+=1
		n2=0

	#détec n
	if posj==posn or (posj[0]==posn[0]+1 and posj[1]==posn[1]) or (posj[0]==posn[0]-1 and posj[1]==posn[1]) or (posj[1]==posn[1]+1 and posj[0]==posn[0]) or (posj[1]==posn[1]-1 and posj[0]==posn[0]):
		posj=[0,0]
		v-=1

	#détec n2
	if posj==posn2 or (posj[0]==posn2[0]+1 and posj[1]==posn2[1]) or (posj[0]==posn2[0]-1 and posj[1]==posn2[1]) or (posj[1]==posn2[1]+1 and posj[0]==posn2[0]) or (posj[1]==posn2[1]-1 and posj[0]==posn2[0]):
		posj=[0,0]
		v-=1
				
	if v==0:
		print('GAME OVER')
		print(f"Vous avez ramassé {c}€")
		quit()

	#print tab
	for y in range(20):
		l=[]
		for x in range(80):
			if x==posj[0] and y==posj[1] or x==posj[0] and y==posj[1]:
				l.append("☻")
			elif (x==posn[0] and y==posn[1]) or (x==posn2[0] and y==posn2[1]):
				l.append("☺")
			elif x==posc[0] and y==posc[1]:
				l.append("€")
			else:
				l.append("█")
		for i in l:
			print(i, end='')
		print('', end='\n')
	print(f'ARGENT : {c} | VIES : {v}')
	print()

	#commande j
	a=msvcrt.getwch()
	clear()
	if a=='d':
		atq=0
		posj[0]+=1
	elif a=='q':
		atq=0
		posj[0]-=1
	if a=='s':
		atq=0
		posj[1]+=1
	elif a=='z':
		atq=0
		posj[1]-=1
	elif a=='0':
		quit()
	elif a=='i':
		print('zqsd : ce déplacer | 0 : arrêter le jeu')

