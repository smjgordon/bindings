/**
 * This package contains functionality pertaining to cairo's
 * XLib support.  Obviously, this package isn't much good
 * on anything but a Windows machine.
 *
 * Currently, since there does not appear to be any standard XLib library for
 * D, this binding defines manual typedefs for the types it needs.  You may
 * like to replace the contents of the file 'cairo_xlib_types.d' with a public
 * import statement to the library you wish to use.
 *
 * Authors: Daniel Keep
 * Copyright: 2006, Daniel Keep
 * License: BSD v2 (http://www.opensource.org/licenses/bsd-license.php).
 */
/*
 * Copyright © 2006 Daniel Keep
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the name of this software, nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module cairo.xlib.cairo_xlib;

public import cairo.xlib.cairotypes_xlib;
public import cairo.xlib.cairofuncs_xlib;

private
{
    import cairo.cairo;
}

/**
 * This function attempts to load the XLib functions from
 * the cairo library.
 */
public void cairo_xlib_load()
{
    cairo_load();
    cairo_xlib_loadprocs(libCairo);
}

/// ditto
public void cairo_xlib_load(char[] libName)
{
    cairo_load(libName);
    cairo_xlib_load();
}

