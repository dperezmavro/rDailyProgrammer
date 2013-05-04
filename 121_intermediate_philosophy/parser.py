#!/usr/bin/python
from sgmllib import SGMLParser
import re

class Parser(SGMLParser):
	def __init__(self):
		SGMLParser.__init__(self)
		self.inRestr = False
		self.currTitle = ''
		self.Title = False
		self.inMain = False 
		self.inP = False 
		self.frstLink = ''
		self.first = True 
		self.start_r = re.compile(r'[\(\[\{]')
		self.end_r = re.compile(r'[\}\]\)]')

	def handle_data(self, data):
		if self.Title :
			self.Title = False 
			self.currTitle = data 
		if self.inP :
			if self.start_r.search(data) :
				self.inRestr = True
			elif self.end_r.search(data) :
				self.inRestr = False

	def start_span(self , attrs):
		ad = self.dictify(attrs)
		if len(attrs) == 1 and 'dir' in ad.keys()  and ad.get('dir') == 'auto':
			self.Title = True
	
	def start_a(self, attrs):
		ad = self.dictify(attrs)
		if self.inP and not self.inRestr and self.first and self.inMain :
			self.first = False 
			self.frstLink = ad.get('href')

	def start_div(self, attrs):
		ad = self.dictify(attrs)
		if len(attrs) > 0 and 'id' in ad and ad.get('id') == 'mw-content-text':
			self.inMain = True 

	def result(self):
		return self.currTitle, self.frstLink

	def start_table (self, attrs):
		self.inRestr = True
	def end_table(self):
		self.inRestr = False
	def i_start(self, attrs):
		self.inRestr = True 
	def i_stop(self):
		self.inRestr = False 
	def start_p(self, attrs):
		self.inP = True 
	def stop_p(self):
		self.inP = False
	def start_sup(self, attrs):
		self.inRestr = True 
	def stop_sup(self):
		self.inRestr = False
	def start_sub(self, attrs):
		self.inRestr = True 
	def stop_sub(self):
		self.inRestr = False
	def dictify (self, attrs_lst):
		return {k[0]:k[1] for k in attrs_lst}
