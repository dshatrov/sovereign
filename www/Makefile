%.html: template.xsl %.xml
	xsltproc -o $@ template.xsl $^

.PHONY: all clean

all:	index.html		\
	readme_rus.html

clean:
	rm -f *.html

