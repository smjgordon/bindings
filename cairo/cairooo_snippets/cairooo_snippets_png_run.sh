#!/bin/bash

if [ ! -d output ]; then
    mkdir output
fi

build -cleanup -release -I.. cairooo_snippets_png && ./cairooo_snippets_png

