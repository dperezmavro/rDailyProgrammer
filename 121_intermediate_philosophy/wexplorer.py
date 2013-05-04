#!/usr/bin/python
import sys 
import urllib2
from parser import Parser

if len(sys.argv) != 2 :
	print 'usage : wexplore.py article-url'
	sys.exit(-1)

hist = [] 
base = 'http://en.wikipedia.org'
currT = '' 
nextTarget = sys.argv[1]
while (currT != 'Philosophy') :
	hist.append(nextTarget)
	print 'Looking at',nextTarget
	request = urllib2.Request(nextTarget)
	request.add_header('User-Agent','CLIClient/1.0')	
	opener = urllib2.build_opener()
	feeddata = opener.open(request).read()
	opener.close()
	par = Parser()
	par.feed(feeddata)
	currT, n =  par.result()
	nextTarget = base+n

print hist
