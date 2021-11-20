
all: page1.png page2.png

demo.pdf: demo.tex manurxiv.cls
	latexmk demo.tex

page%.png: demo.pdf
	inkscape -b ffffffff-C -o $@ --pdf-page=$* --pdf-poppler demo.pdf
