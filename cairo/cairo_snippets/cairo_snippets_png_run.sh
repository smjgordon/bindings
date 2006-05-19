#!/bin/bash

if [ ! -d output ]; then
    mkdir output
fi

build -cleanup -release -I.. cairo_snippets_png && ./cairo_snippets_png

