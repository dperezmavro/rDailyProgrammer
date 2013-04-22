#!/usr/bin/python
import sys 
num = sys.argv[1]

def s(l):
	return sum([int(i) for i in l])

while int(num)> 9 :
	num = s(str(num))

print num
