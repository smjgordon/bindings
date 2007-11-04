#!/usr/bin/env dmd -run
/+
    To run this program, and see usage options, use this command:

    dmd -run cairo-build.d --help

    If "dmd -run ..." does not work or produces errors, then use the
    following:

    build -clean cairo-build.d
    cairo-build --help
+/
/**
 * cairo binding for D build script
 *
 * Copyright: &copy; 2006 Daniel Keep
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
module cairo_build;
import util.script;
mixin Script;

/* ************************************************************************* */

const SCRIPT_NAME = "cairo binding build script";

const Target
    TARGET_CAIRO = {name:"cairo", type:"lib", target:"lib/cairo",
        sources:["cairo/cairo.d"]},
    TARGET_GLITZ = {name:"glitz", type:"lib", target:"lib/cairo_glitz",
        sources:["cairo/glitz/cairo_glitz.d"]},
    TARGET_PDF = {name:"pdf", type:"lib", target:"lib/cairo_pdf",
        sources:["cairo/pdf/cairo_pdf.d"]},
    TARGET_PNG = {name:"png", type:"lib", target:"lib/cairo_png",
        sources:["cairo/png/cairo_png.d"]},
    TARGET_PS = {name:"ps", type:"lib", target:"lib/cairo_ps",
        sources:["cairo/ps/cairo_ps.d"]},
    TARGET_SVG = {name:"svg", type:"lib", target:"lib/cairo_svg",
        sources:["cairo/svg/cairo_svg.d"]},
    TARGET_WIN32 = {name:"win32", type:"lib", target:"lib/cairo_win32",
        flags:["-Xwin32"], sources:["cairo/win32/cairo_win32.d"]},
    TARGET_WIN32_DFL = {name:"win32-dfl", type:"lib",
        target:"lib/cairo_win32_dfl",
        flags:["-Xwin32","-Xdfl","-version=cairo_dfl"],
        sources:["cairo/win32/cairo_win32.d"]},
    TARGET_XLIB = {name:"xlib", type:"lib", target:"lib/cairo_xlib",
        sources:["cairo/xlib/cairo_xlib.d"]};

version(Windows)
    const Target
        TARGET_ALL = {name:"all", type:"dummy",
            deps:[&TARGET_CAIRO, &TARGET_GLITZ, &TARGET_PDF,
                  &TARGET_PNG, &TARGET_PS, &TARGET_SVG,
                  &TARGET_WIN32]};
version(linux)
    const Target
        TARGET_ALL = {name:"all", type:"dummy",
            deps:[&TARGET_CAIRO, &TARGET_GLITZ, &TARGET_PDF,
                  &TARGET_PNG, &TARGET_PS, &TARGET_SVG,
                  &TARGET_XLIB]};

const Target[] TARGETS =
    [TARGET_ALL, TARGET_PNG, TARGET_CAIRO, TARGET_GLITZ, TARGET_WIN32,
     TARGET_WIN32_DFL, TARGET_XLIB, TARGET_PDF, TARGET_PS, TARGET_SVG];
const DEFAULT_TARGET = &TARGET_ALL;
const DEBUG_TARGET_SUFFIX = "_debug";

const char[][] FLAGS = ["-allobj","-cleanup"];
const char[][] FLAGS_DEBUG = ["-debug","-unittest","-version=Unittest","-g"];
const char[][] FLAGS_RELEASE = ["-release","-inline","-O"];

/* ************************************************************************* */

struct Target
{
    char[] name;
    char[] type; /// "exe", "lib" or "dummy"
    char[] target;
    char[][] sources = [];
    char[][] flags = [];
    Target*[] deps = [];

    int
    opCmp(Target other)
    {
        return std.string.cmp(this.name, other.name);
    }
    
    int
    opEquals(Target other)
    {
        return cast(int) (std.string.cmp(this.name, other.name) == 0);
    }

    char[]
    toString()
    {
        return this.name;
    }
}

char[][]
names(Target[] ts)
{
    char[][] result;
    foreach( t ; ts )
    {
        result.pushBack(t.name);
    }
    return result;
}

static
this()
{
    TARGETS.sort;
}

void
showHelp()
{
    echof(
`%s
Usage:
    %s [OPTIONS] [TARGET...]

Options:
    --debug         Add debugging code, symbols and unit tests.
    --release       Strip out debug code, and enable optimisations.
    --verbose       Verbose script commands.
    --very-verbose  Verbose script AND toolchain commands.
    --help          This message.
    +arg            "arg" is passed on to the compiler verbatim.

Supported targets:
    %s

The default target is "%s".`,
            SCRIPT_NAME,
            "dmd -run cairo-build.d",
            std.string.join(names(TARGETS), ", "),
            DEFAULT_TARGET.name);
}

bool
contains(Target[] ts, Target value)
{
    foreach( t ; ts )
        if( t == value )
            return true;
    return false;
}

template pushBack(T)
{
    void
    pushBack(inout T[] a, T value)
    {
        a.length = a.length + 1;
        a[$-1] = value;
    }
}

int
main(char[][] args)
{
    bool debugVersion = false;
    bool veryVerbose = false;
    char[][] targetNames;
    char[][] extraFlags;
    
    // Check for flags
    foreach( arg ; args[1..$] )
    {
        if( arg == "--debug" )
            debugVersion = true;
        else if( arg == "--release" )
            debugVersion = false;
        else if( arg == "--verbose" )
            verboseCommands = true;
        else if( arg == "--very-verbose" )
            veryVerbose = true;
        else if( arg == "--help" )
        {
            showHelp();
            return 0;
        }
        else if( arg[0] == '+' )
        {
            extraFlags.pushBack(arg[1..$]);
        }
        else if( arg[0..2] == "--" )
        {
            echof("Unknown argument: %s", arg);
            return 2;
        }
        else
            targetNames.pushBack(arg);
    }

    if( targetNames.length == 0 )
        targetNames.pushBack(DEFAULT_TARGET.name);

    // Ok, build list of targets to build
    Target[] targets;

TargetNames:
    foreach( targetName ; targetNames )
    {
        foreach( target ; TARGETS )
        {
            if( target.name == targetName )
            {
                if( !targets.contains(target) && target.type != "dummy" )
                    targets.pushBack(target);

                foreach( deptarget ; target.deps )
                    if( !targets.contains(*deptarget)
                            && deptarget.type != "dummy" )
                        targets.pushBack(*deptarget);

                continue TargetNames;
            }
        }
    }

    // Ok, start building!
    foreach( target ; targets )
    {
        if( verboseCommands ) echof(`Building target "%s"...`, target.name);
        
        // Build list of flags
        char[][] flags;
        flags ~= FLAGS;
        if( debugVersion )
            flags ~= FLAGS_DEBUG;
        else
            flags ~= FLAGS_RELEASE;

        switch( target.type )
        {
            case "exe":
                flags ~= "-nolib";
                break;

            case "lib":
                flags ~= "-lib";
                break;
        }

        if( debugVersion )
            flags ~= "-T" ~ target.target ~ DEBUG_TARGET_SUFFIX;
        else
            flags ~= "-T" ~ target.target;

        if( veryVerbose )
            flags ~= "-v";

        // Do the build
        build(flags ~ target.flags ~ extraFlags ~ target.sources);
    }

    return 0;
}

