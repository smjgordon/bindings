
.. This document is written in reStructuredText.
.. Build command:
   rst2html.py --date --time README.rst README.html

======================
 cairo bindings for D
======================

.. contents::

Introduction
============

This project's aim is to provide a complete, up-to-date D binding for the
cairo_ 2D drawing API.  Currently, the binding supports the base cairo
functions and PNG functions.  It also contains support for the Glitz, Win32
and Xlib backends, but these are largely untested.

This project also provides an object-oriented layer above the raw bindings
called ``cairooo`` which adds support for objects and exceptions, integrating
cairo more seamlessly with D style programming.  In time, we hope to also
provide a library of additional, high-level functionality with this layer.

Installation
============

cairo binding
-------------

To install, simply copy the ``cairo`` directory to a place in your D
compiler's import path.  That's all there is to it.

If you really want to have import libraries to use, then you can build these
using the ``cairo-build.d`` script, which will place them in the ``lib``
directory.  It can be run using either::

  dmd -run cairo-build.d ARGS

Or, if that fails::

  build cairo-build.d
  cairo-build ARGS

The command line arguments may be empty (signifying a default build), or
contain one or more targets to build.  You may also use the ``--verbose``
switch to get more verbose output, and the ``--debug`` switch to produce
libraries with debug symbols [#debuglibs]_.

Use the ``--help`` switch for full usage information.

Also, please note that if you are building static libraries that these
libraries only compile for one particular version of cairo at a time.  To
select which version of the cairo API you want to compile for, you need to use
the following additional arguments to the build script:

* cairo 1.0: no arguments needed.
* cairo 1.2: ``+--version=cairo_1_2``
* cairo 1.4: ``+--version=cairo_1_4``

You will also need to specify the same version identifier when you compile
your programs.

cairooo binding
---------------

To install the cairooo binding, simply copy both the ``cairo`` and ``cairooo``
directories to a place on your D compiler's import path.

If you want to build import libraries, then you can use the
``cairooo-build.d`` script, which will build them to the ``lib`` directory.
Usage is mostly the same as using ``cairo-build.d`` (see above).

Note that cairooo currently does not support cairo 1.2 or 1.4.

cairo snippets
--------------

The ``cairo_snippets`` and ``cairooo_snippets`` directories contain the
"snippets" example programs provided by the cairo developers ported to D.
They use the ``cairo`` and ``cairooo`` bindings respectively.

These do not have a "proper" build script like the binding itself: they are
generally built with either a Windows batch file or shell script.  However, if
you wish to build them manually, the command to do so usually looks like
this::

  build -cleanup -release -inline -I.. NAME_OF_SNIPPET

Just be sure to create the ``output`` directory if it does not exist first.

cairooo tutorial
----------------

The ``cairooo_tutorial`` contains the beginnings of a very simple introductory
tutorial to programming image programs in D using the cairooo binding.  It is
pathetically incomplete; however, it may be a useful starting point.

demos
-----

The ``demos`` directory will contain a few small demo programs to showcase the
binding.  Currently, it only has one demo, so the plural is prehaps
misleading.  Hopefully this will change :)

documentation
-------------

Whilst this project hopes to eventually have full DDoc documentation for the
cairooo binding, we will not be providing anything other than minimal
documentation for the raw cairo API binding.  The rationale is that since the
original C api and the raw D api are for the most part identical, there is no
need to duplicate the existing C documentation.

That said, the cairooo documentation itself is woefully lacking.  What does
exist can be built using the following command::

  build @build_docs_cairooo.brf

Please note that you will need to create the following directory structure
*first* if it does not yet exist::

  docs\
    cairooo\
      extra\
      glitz\
      png\
      win32\
      xlib\

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

cairo
-----

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

To select a particular version of the cairo library, make sure you compile
with an appropriate version flag:

* cairo 1.0: no version flag necessary.
* cairo 1.2: --version=cairo_1_2.
* cairo 1.4: --version=cairo_1_4.

From there, just start using the cairo API as you would from C.  The cairo
website contains a collection of `example snippets`_ in C, and this binding
comes complete with the majority of these examples converted to D.  Just
look in the ``cairo_snippets`` directory.

cairooo
-------

To use the cairooo binding instead, import ``cairooo.all``, along with any
other parts of the library that you need.  To copy the above example, to
import the base and PNG functions::

  import cairooo.all;
  import cairooo.png.all;

As with the raw binding, you need to tell the binding to load the cairo
library before you can use it.  You can do that like so::

  Cairo.load();
  CairoPNG.load();

Again, if anything fails to load, an exception will be thrown.

There are no huge, arbitrary differences between the flat C api and the
object-oriented one.  The largest change is that anywhere you would pass a
handle, you instead pass an object.  The naming translation is roughly::

  cairo_foo_bar_xxx_t* --> FooBarXXX

An exception to this is the cairo context, ``cairo_t*``, which becomes
``Context``.

Also, the following differences should be kept in mind:

* "lower_case_with_underscores" functions become "lowerCaseWithUnderscores".
* "CAIRO_ENUM_TYPE_ENUM_NAME" becomes "EnumType.enumName".

Finally, where there have been multiple ways of creating a certain kind of
object (such as a Surface or Pattern), creating them is split between using
constructors and static members.  This will get resolved eventually, but for
the moment, which one to use is unclear.

The general rule is that if you want to convert::
  
  xxx = cairo_some_object_create_foo(arg1, arg2, ...);

You should try the following::

  xxx = new SomeObject(arg1, arg2, ...);
  xxx = SomeObject.create(arg1, arg2, ...);
  xxx = SomeObject.createFoo(arg1, arg2, ...);

For more concrete examples, see the ``cairooo_snippets``, ``cairooo_tutorial``
and ``demos`` directories.

Contributing
============

The cairo api has a functionality in it that this binding does not
yet cover: PDF abd PS for example.  However, the only binary version of cairo
I have access to is limited to what is currently covered, and I have thus
far had no success in compiling cairo myself.

So, currently the best way to contribute is to contribute and maintain a
binding for some currently unsupported part of cairo.  You can look at the
PNG binding for a simple example.

That, or you can write samples and demos to test the bindings that I can't.
In addition to being fun, you get to make pretty pictures in the process!

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

.. Footnotes

.. [#debuglibs] The debug libraries will have "_debug" appended to their
                filename, so you do not need to worry about overwriting your
                release libraries.


