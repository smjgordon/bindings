
.. This document is written in reStructuredText.
.. Build command:
   rst2html.py --date --time README.rst README.html

======================
 cairo bindings for D
======================

Introduction
============

This project's aim is to provide a complete, up-to-date D binding for the
cairo_ 2D drawing API.  Currently, the binding supports the base cairo
functions, PNG functions, and Win32 functions.

Installation
============

To install, simply copy the ``cairo`` directory to a place in your D
compiler's import path.  That's all there is to it.  Currently, there is no
automated support for building an import library, although this is planned
for a future release (ie: when I get around to it).

cairo for Windows
-----------------

If you are using Windows, you will also probably want to grab the cairo
library itself.  The best version I have found is on `Tor Lillqvist`_'s
`GTK+ for Windows`_ website.

If you go to that page, you will need to download the following packages:

* cairo-1.x.y.zip
* libpng 1.x.y binaries zip
* Zlib 1.x.y

Specifically, you're after ``libcairo-2.dll``, ``libpng13.dll`` and
``zlib1.dll``.  Just place these files into either your system path
somewhere, or (a better idea) place them in the working directory of any
programs you're developing.

.. _Tor Lillqvist: http://www.iki.fi/tml/index.html
.. _GTK+ for Windows: http://www.gimp.org/%7Etml/gimp/win32/downloads.html

Usage
=====

To use the binding, simply import ``cairo.cairo``, along with any other
parts of the library you need.  For example, if you wanted the base cairo
functionality, along with the PNG functions, you would add the following to
your code::

  import cairo.cairo;
  import cairo.png.cairo_png;

Also, before using the cairo library, you need to tell it to load the actual
library proper.  You can do this like so::

  cairo_load();
  cairo_png_load();

If some part of the library fails to load, these functions will thrown an
exception which can be caught and dealt with.

From there, just start using the cairo API as you would from C.  The cairo
website contains a collection of `example snippets`_ in C, and this binding
comes complete with the majority of these examples converted to D.  Just
look in the ``cairo_snippets`` directory.

Contributing
============

The cairo api has a lot of functionality in it that this binding does not
yet cover: X11, PDF, PS and more.  However, the only binary version of cairo
I have access to is limited to what is currently covered, and I have thus
far had no success in compiling cairo myself.

So, currently the best way to contribute is to contribute and maintain a
binding for some currently unsupported part of cairo.  You can look at the
PNG binding for a simple example.

Thanks
======

* Many thanks for the hard work by the people behind the cairo library.

* Also, thanks to Michael Parker for letting me steal Derelict_'s dynamic
  loader code.

Credits
=======

cairo bindings for D Copyright © 2006 Daniel Keep.  Portions Copyright ©
2006 Michael Parker.

Released under the `BSD license`_.

.. Links

.. _BSD license: http://www.opensource.org/licenses/bsd-license.php
.. _cairo: http://cairographics.org/
.. _Derelict: http://www.dsource.org/projects/derelict/
.. _example snippets: http://cairographics.org/samples/

