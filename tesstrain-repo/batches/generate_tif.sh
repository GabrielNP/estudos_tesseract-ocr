#!/bin/sh

for f in *.gt.txt;
	do
		text2image --text $f \
			--outputbase $f \
			--find_fonts  \
			--fonts_dir ../../../fonts \
			--font Courier \
			--render_per_font false \
			--min_coverage .8;
	done