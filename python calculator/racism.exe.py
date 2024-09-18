from random import randint

p=0

c=randint(0,19)

s=0 

estate="*"
e=randint(0,19)

while True:
  if estate=="n":
    e=randint(0,19)
    estate="!"
  elif estate=="!":
    estate="*"
  elif estate=="*":
    estate="n"
  
  l=[]
  for i in range(20):
    l.append(" ")
  
  for i in range(len(l)):
    if i==c:
      l[i]="o"
    if i==p:
      l[i]="+"
    if i==e and estate=="!":
      l[i]="!"
    if i==e and estate=="*":
      l[i]="*"
    print(l[i],end="")
  if c==p:
    s+=1
    c=randint(0,19)
  if "+" not in l and estate=="*":
    print("u ded with "+str(s))
    break
  
  print(" score : "+str(s))
    
  a=input()

  if a=="4": 
    p-=1
  elif a=="6":
    p+=1
  if p<0:
    p=0
  elif p>19:
    p=19