
D Logo Demo
===========

This demo outputs the D logo designed by FunkyM in your choice of red, blue,
greyscale and monochrome.  At time of writing, this is in *no way* the
offficial logo: just a proposed one that I happened to rather like.

To compile the program, use the provided build .brf file for your operating
system.  You can also specify the colour you would like to have the logo
rendered in.

Examples:

* `build @dlogo.win32.brf` — outputs a red logo
* `build @dlogo.linux.brf` — as above, but for Linux users
* `build -version=Blue @logo.win32.brf` — renders logo in blue
* `build -version=Grey @logo.win32.brf` — renders logo in greyscale
* `build -version=Mono @logo.win32.brf` — renders logo in monochrome

