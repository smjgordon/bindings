#!/usr/bin/env dmd -run
/+
    To run this program, and see usage options, use this command:

    dmd -run cairooo-build.d --help

    If "dmd -run ..." does not work or produces errors, then use the
    following:

    build -clean cairooo-build.d
    cairooo-build --help
+/
/**
 * Object-oriented cairo binding for D build script
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
module cairooo_build;
import util.script;
mixin Script;

/* ************************************************************************* */

const SCRIPT_NAME = "Object oriented cairo binding build script";

const Target
    TARGET_CAIRO = {name:"cairooo", type:"lib", target:"lib/cairooo",
        sources:["cairooo/all.d"]},
    TARGET_GLITZ = {name:"glitzoo", type:"lib", target:"lib/cairooo_glitz",
        sources:["cairooo/glitz/all.d"]},
    TARGET_PNG = {name:"pngoo", type:"lib", target:"lib/cairooo_png",
        sources:["cairooo/png/all.d"]},
    TARGET_WIN32 = {name:"win32oo", type:"lib", target:"lib/cairooo_win32",
        flags:["-Xwin32"], sources:["cairooo/win32/all.d"]},
    TARGET_WIN32_DFL = {name:"win32oo-dfl", type:"lib",
        target:"lib/cairooo_win32_dfl",
        flags:["-Xwin32","-Xdfl","-version=cairo_dfl"],
        sources:["cairooo/win32/all.d"]},
    TARGET_XLIB = {name:"xliboo", type:"lib", target:"lib/cairooo_xlib",
        sources:["cairooo/xlib/all.d"]},
    TARGET_EXTRA = {name:"extra", type:"lib", target:"lib/cairooo_extra",
        sources:["cairooo/extra/all.d"]};

version(Windows)
    const Target
        TARGET_ALL = {name:"all", type:"dummy",
            deps:[&TARGET_CAIRO, &TARGET_GLITZ, &TARGET_PNG, &TARGET_WIN32,
                &TARGET_EXTRA]};
version(linux)
    const Target
        TARGET_ALL = {name:"all", type:"dummy",
            deps:[&TARGET_CAIRO, &TARGET_GLITZ, &TARGET_PNG, &TARGET_XLIB,
                &TARGET_EXTRA]};

const Target[] TARGETS =
    [TARGET_ALL, TARGET_PNG, TARGET_CAIRO, TARGET_GLITZ, TARGET_WIN32,
     TARGET_WIN32_DFL, TARGET_XLIB, TARGET_EXTRA];
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

Supported targets:
    %s

The default target is "%s".`,
            SCRIPT_NAME,
            "dmd -run cairooo-build.d",
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
        build(flags ~ target.flags ~ target.sources);
    }

    return 0;
}

