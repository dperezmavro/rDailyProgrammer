#!/usr/bin/python
import sys

stack = list()
matches = {')':'(',']':'[','>':'<','}':'{'}
for i,p in enumerate(sys.argv[1]) :
	if p in '<{[(':
		stack.append((p,i))
	elif p in matches.keys() and matches.get(p) != stack.pop()[0]:
		print 'unmatched character in position',i,'("',p,'")! terminating...'
		sys.exit(1)
	else : pass

if len(stack) == 0 : 
	print 'Parsing Ok.'
else:
	print 'parsing error, unmatched brackets:',','.join(['char '+i[0]+' @pos '+str(i[1]) for i in stack])
