@ECHO OFF
mkdir output 2>NUL
build -cleanup -release -I.. cairooo_snippets_png && cairooo_snippets_png
