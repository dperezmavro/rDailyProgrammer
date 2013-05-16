#/usr/bin/python

import sys

G = dict()
visited = list()

with open(sys.argv[1]) as f :
	for line in f.readlines() :
		e =line.rstrip().split(' ') 
		if len(e) == 2 :
			if e[0] in G :
				G[e[0]].append(e[1])
			else:
				G[e[0]] = [e[1]]

def walk(fr, to ) :
	if fr in visited : 
		print ' '.join(visited),fr 
		sys.exit(1)
	else :
		visited.append(fr)

	for i in to:
		if i in G :
			walk(i, G[i])
			visited.remove(i)
	

for (k,v) in G.items():
	walk(k,v)
	visited = [] 
print G 
