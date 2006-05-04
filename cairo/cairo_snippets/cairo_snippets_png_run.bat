@ECHO OFF
mkdir output 2>NUL
build -cleanup -release -I.. cairo_snippets_png && cairo_snippets_png
