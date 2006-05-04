
cairo snippets
==============

This folder contains a translated copy of the cairo snippet samples as found
at http://cairographics.org/samples/.

Currently, only the png "front end" has been ported, since this is the only
one supported by the binding at this time.  Also, almost all cairo library
binaries will have png support, so it's a fairly safe bet.

Finally, not all samples were ported.  The "libsvg" sample was not ported since
the binding does not yet support cairo's SVG functions.  Also, samples
starting with "xxx_" were not ported, since these are used to demonstrate
bugs in the current version of cairo.

Windows users can compile and run the samples using the
"cairo_snippets_png_run.bat" file, whilst Linux users can use the
"cairo_snippets_png_run.sh" file (note that this has NOT been tested yet).

