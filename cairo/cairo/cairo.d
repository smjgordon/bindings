/**
 * cairo bindings for D.
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
module cairo.cairo;

public import cairo.cairotypes;
public import cairo.cairofuncs;

private import cairo.loader;
package SharedLib libCairo;

/**
 * This function will attempt to load the cairo library.
 */
public void cairo_load( char[] libName )
{
    if( libCairo !is null )
        return;
    
    libCairo = loadSharedLib(libName);

    /* Try to find out what version of cairo we've got.  If it's too old,
     * throw an exception explaining this.
     */
    auto versionnum = (cast(pf_cairo_version)
            getProc(libCairo,"cairo_version"))();

    version( cairo_1_4 )
        auto expected_version = CAIRO_VERSION_ENCODE(1,4,0);

    else version( cairo_1_2 )
        auto expected_version = CAIRO_VERSION_ENCODE(1,2,0);
    
    else
        auto expected_version = CAIRO_VERSION_ENCODE(1,0,0);
    
    if( versionnum < expected_version )
        throw new CairoVersionException(versionnum, expected_version);

    // Now we can actually load the functions.
    cairo_loadprocs(libCairo);
}

/// ditto
public void cairo_load()
{
    version(Windows)
        cairo_load("libcairo-2.dll");
    else version(linux)
        cairo_load("libcairo.so");
    else
    {
        pragma(msg, "I'm sorry, but implicit loading is not supported on"
                    " your platform.  Please call cairo_load with the"
                    " name of the library to load.");
        pragma(msg, "If you would like to help, please contact us with"
                    " the name of your platform, your compiler, and the"
                    " name of the cairo library for your platform."
                    "  Thankyou, and sorry for the inconvenience.");
        static assert(0);
    }
}

/**
 * This will unload the cairo library from memory.  This will be
 * called automatically when your program terminates
 */
public void cairo_unload()
{
    if( libCairo is null )
        return;
    
    unloadSharedLib(libCairo);
    libCairo = null;
}

version( Tango )
{
    import tango.text.convert.Integer : toUtf8;
    alias toUtf8 intToString;
}
else
{
    import std.string : toString;
    alias toString intToString;
}

private char[] verToString(int ver)
{
    return intToString(ver/100_00)
        ~ "." ~ intToString((ver/100)%100)
        ~ "." ~ intToString(ver%100);
}

private class CairoVersionException : Exception
{
    this(int got, int expected)
    {
        this("expected cairo version "~verToString(expected)
                ~", got version "~verToString(got)~".");
    }

    this(char[] msg)
    {
        super(msg);
    }
}

static ~this()
{
    cairo_unload();
}

