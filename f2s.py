
import os
import numpy as np



def datageneration(symbols, symbol2name):
	for c, s in enumerate(symbols):
		dirname = "tex/%s" % symbol2name[s]
		filename = symbol2name[s]
		if not os.path.exists(dirname):
			os.makedirs(dirname)
		os.system("sed 's/MAGIC/%s/g' tex/symbols.template.tex > tex/%s/%s.tex" % (s, filename, filename))
		os.chdir(dirname)
		os.system("pdflatex %s.tex > /dev/null" % filename)
		os.system("convert -density 400 %s.pdf %s.png" % (filename, filename))
		os.chdir('../..')

if __name__ == '__main__':
	symbols = list("1234567890()")
	symbols.extend("+-x")
	names = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "zero", "lparen", "rparen", "plus", "minus", "multiply"]
	symbol2name = {symbols[i]: names[i] for i in xrange(len(symbols))}
	datageneration(symbols, symbol2name)