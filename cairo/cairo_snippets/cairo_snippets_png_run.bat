@ECHO OFF
mkdir output 2>NUL
bud -cleanup -release -I.. cairo_snippets_png && cairo_snippets_png
