PREF=2022-NaaktgeborenC-TribOrigins

clean:
	for EXT in log aux blg bbl out toc dvi; do \
		rm -vf ${PREF}.$$EXT; \
	done

cc/%.png: cc/%.png.url
	wget \
		--input-file=$< \
		--output-document=$@ \
		--user-agent="Mozilla/5.0 (X11; Linux x86_64)"
	touch $@

cc/%.svg: cc/%.svg.url
	wget \
		--input-file=$< \
		--output-document=$@ \
		--user-agent="Mozilla/5.0 (X11; Linux x86_64)"
	touch $@

cc/%.pdf: cc/%.svg
	inkscape \
		--export-type=pdf \
		--export-pdf-version=1.4 \
		--export-filename=$@ \
		$<

ref/%.pdf: ref/%.pdf.url
	wget \
		--input-file=$< \
		--output-document=$@ \
		--user-agent="Mozilla/5.0 (X11; Linux x86_64)"
	touch $@

fig/%.pdf: fig/%.svg
	inkscape \
		--export-type=pdf \
		--export-pdf-version=1.4 \
		--export-filename=$@ \
		$<

%.ps: fig/%.pdf
	inkscape \
		--export-type=ps \
		--export-filename=$@ \
		$<

${PREF}.pdf: ${PREF}.tex 0*tex PreprintVersion.tex \
		cc/by.pdf \
		bibfile.bib
	xelatex --enable-write18 ${PREF}.tex
	bibtex ${PREF}
	xelatex --enable-write18 ${PREF}.tex
	xelatex --enable-write18 ${PREF}.tex

