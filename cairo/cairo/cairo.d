/**
 * cairo bindings for D.
 * 
 * Copyright: \&copy; 2006 Daniel Keep
 * License: BSD <http://www.opensource.org/licenses/bsd-license.php>
 */
/*
 * Copyright (c) 2006 Daniel Keep
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

import cairo.cairotypes;
import cairo.cairofuncs;

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
    cairo_loadprocs(libCairo);
}

/// ditto
public void cairo_load()
{
    version(Windows)
        cairo_load("libcairo-2.dll");
    else version(linux)
        cairo_load("libcairo-2.so");
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

static ~this()
{
    cairo_unload();
}

