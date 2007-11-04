/**
 * This file implements the code to dynamically load the cairo
 * library under various platforms.  It is largely stolen from
 * the Derelict project's loader.d file.
 *
 * Authors: Derelict developers, Daniel Keep
 * Copyright: 2005-2006 Derelict developers, 2006 Daniel Keep.
 * License: BSD v2 (http://www.opensource.org/licenses/bsd-license.php).
 */
/*
 * Copyright © 2006 Daniel Keep.
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
/*
 * Copyright (c) 2005-2006 Derelict Developers
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
 * * Neither the names 'Derelict', 'DerelictUtil', nor the names of its contributors
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
module cairo.loader;

private
{
    import std.string;
}

/**
 * This class represents a loaded library.  The actual instances
 * will likely by of a subclassed type specific to the current
 * platform.
 */
class SharedLib
{
private:
    char[] name;

    this(char[] name)
    {
        this.name = name;
    }

public:
    char[] toString()
    {
        return "SharedLib("~name~")";
    }
}

class CairoLoaderException : Exception
{
    this(char[] msg)
    {
        super(msg);
    }
}

class SharedLibLoadException : CairoLoaderException
{
    this(char[] libName)
    {
        super("Failed to load shared library \""
                ~ libName ~ "\".");
    }
}

class ProcNotFoundException : CairoLoaderException
{
    this(SharedLib lib, char[] procName)
    {
        super("Could not find procedure \""
                ~ procName ~ "\" in shared library \""
                ~ lib.name ~ "\".");
    }
}

/**
 * Attempts to load the given library.
 */
SharedLib loadSharedLib(char[] libName)
in
{
    assert(libName !is null);
}
out(result)
{
    assert(result !is null);
}
body
{
    return loadSharedLibPlatform(libName);
}

/**
 * Unloads the given shared library.  It is safe to call this
 * method on a library that has already been unloaded.
 */
void unloadSharedLib(SharedLib lib)
in
{
    assert(lib !is null);
}
body
{
    if( lib !is null )
        unloadSharedLibPlatform(lib);
}

/**
 * Attempts to load the given procedure from the shared
 * library.
 */
void* getProc(SharedLib lib, char[] procName)
in
{
    assert(lib !is null);
    assert(lib !is null);
}
out(result)
{
    assert(result != null);
}
body
{
    return getProcPlatform(lib, procName);
}

/**
 * Windows-specific implementation.
 */
version(Windows)
{
    private import std.c.windows.windows;

    class WinSharedLib : SharedLib
    {
    private:
        HMODULE handle;

        this(HMODULE handle, char[] name)
        {
            super(name);
            this.handle = handle;
        }
    }

    SharedLib loadSharedLibPlatform(char[] libName)
    in
    {
        assert(libName !is null);
        assert(libName.length > 0);
    }
    out(result)
    {
        assert(result !is null);
        assert(cast(WinSharedLib)result !is null);
        assert((cast(WinSharedLib)result).handle != null);
    }
    body
    {
        HMODULE hlib = LoadLibraryA(toStringz(libName));
        if( hlib is null )
            throw new SharedLibLoadException(libName);

        return new WinSharedLib(hlib, libName);
    }

    void unloadSharedLibPlatform(SharedLib lib)
    in
    {
        assert(cast(WinSharedLib)lib !is null);
    }
    out
    {
        assert((cast(WinSharedLib)lib).handle is null);
    }
    body
    {
        WinSharedLib winlib = cast(WinSharedLib)lib;
        if( winlib.handle != null )
        {
            FreeLibrary(winlib.handle);
            winlib.handle = cast(HMODULE)null;
        }
    }

    void* getProcPlatform(SharedLib lib, char[] procName)
    in
    {
        assert(lib !is null);
        assert(cast(WinSharedLib)lib !is null);
        assert(procName !is null);
        assert(procName.length > 0);
    }
    out(result)
    {
        assert(result != null);
    }
    body
    {
        auto winlib = cast(WinSharedLib)lib;
        void* proc = GetProcAddress(winlib.handle, toStringz(procName));
        if( proc == null )
            throw new ProcNotFoundException(lib, procName);

        return proc;
    }
}
/**
 * Linux-specific implementation.
 */
else version(linux)
{
    version(build)
    {
        pragma(link, dl);
    }
    else
    {
        pragma(lib, "dl.a");
    }
    
    private import std.c.linux.linux;

    private typedef void* HLIB;
    
    class LinuxSharedLib : SharedLib
    {
    private:
        HLIB handle;

        this(HLIB handle, char[] libName)
        {
            super(libName);
            this.handle = handle;
        }
    }
    
    SharedLib loadSharedLibPlatform(char[] libName)
    in
    {
        assert(libName !is null);
        assert(libName.length > 0);
    }
    out(result)
    {
        assert(result !is null);
        assert(cast(LinuxSharedLib)result !is null);
        assert((cast(LinuxSharedLib)result).handle != null);
    }
    body
    {
        HLIB handle = cast(HLIB)dlopen(toStringz(libName), RTLD_NOW);
        if( handle == null )
            throw new SharedLibLoadException(libName);

        return new LinuxSharedLib(handle, libName);
    }

    void unloadSharedLibPlatform(SharedLib lib)
    in
    {
        assert(lib !is null);
        assert(cast(LinuxSharedLib)lib !is null);
    }
    out
    {
        assert((cast(LinuxSharedLib)lib).handle == null);
    }
    body
    {
        auto plib = cast(LinuxSharedLib)lib;
        if( plib.handle != null )
        {
            dlclose(cast(void*)plib.handle);
            plib.handle = null;
        }
    }

    void* getProcPlatform(SharedLib lib, char[] procName)
    in
    {
        assert(lib !is null);
        assert(cast(LinuxSharedLib)lib !is null);
        assert((cast(LinuxSharedLib)lib).handle != null);
        assert(procName !is null);
        assert(procName.length > 0);
    }
    out(result)
    {
        assert(result != null);
    }
    body
    {
        auto plib = cast(LinuxSharedLib)lib;
        void* proc = dlsym(cast(void*)plib.handle, toStringz(procName));
        if( proc == null )
            throw new ProcNotFoundException(lib, procName);

        return proc;
    }
}
else
{
    pragma(msg, "Sorry; the cairo loader isn't supported on your system.");
    pragma(msg, "If you would like to help, please check the cairo/loader.d"
                " file, and see if you can implement the *Platform"
                " functions for your platform, then send them to us so we"
                " can incorporate them into the official distribution."
                "  Thankyou, and sorry for the inconvenience.");
    static assert(0);
}

