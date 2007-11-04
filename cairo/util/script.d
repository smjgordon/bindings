/+
	Copyright (c) 2006 Eric Anderton
    Modifications made by Daniel Keep
        
	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without
	restriction, including without limitation the rights to use,
	copy, modify, merge, publish, distribute, sublicense, and/or
	sell copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following
	conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	OTHER DEALINGS IN THE SOFTWARE.
+/
module util.script;

public import std.file;
public import std.format;
public import std.path;
public import std.process;
public import std.stdio;
public import std.string;
public import std.zip;
public import std.c.stdio;

version(Windows) {}
else version(linux) {}
else
{
    pragma(msg, "Sorry; your platform is not supported by the script
            library.");
    static assert(0);
}

// NOTE: the odd use of templates here is to force the template instances to
// compile into the referencing module.  This way, scripts built on top of
// these commands can be created w/o need for the 'build' tool.  

// Simply mixin the Script template to use these functions in your .ds files

template Script()
{
    bool verboseCommands = false;
    
    version(Windows)
    {
        const EXEFILE = ".exe";
        const OBJFILE = ".obj";
        const LIBFILE = ".lib";
        const DLLFILE = ".dll";
    }
    version(linux)
    {
        const EXEFILE = "";
        const OBJFILE = ".o";
        const LIBFILE = ".a";
        const DLLFILE = ".so";
    }
    
	int
    exec(char[] pathname, char[][] params ...)
    {
		char[] command = escape(fixPath(pathname));
		foreach(str; params) command ~= " " ~ escape(str);
        if( verboseCommands ) echo(command);
		system(command);
		return 0;
	}

    void
    echo(char[][] params ...)
    {
        foreach( param ; params ) writef("%s", param);
        writefln("");
    }

    /+void
    echof(...)
    {
        // D really needs argument exploding...
        writefx(stdout, _arguments, _argptr, true);
    }+/

    void
    echof(T...)(T args)
    {
        writefln("", args);
    }

    char[]
    escape(char[] string)
    {
        // This is really dumb at the moment; it doesn't handle escaping
        // quotes, etc.  Really need to write a proper implementation...
        if( string.find(' ') != -1 )
            return "\"" ~ string ~ "\"";
        else
            return string;
    }

	char[]
    fixPath(char[] path)
    {
		version(Windows) return std.string.replace(path,"/","\\");
		version(linux) return std.string.replace(path,"\\","/");
	}

	void
    build(char[][] options ...)
    {
        char[][] opts;
        foreach( opt ; options )
        {
            opts.length = opts.length + 1;
            opts[$-1] = fixPath(opt);
        }
        exec("bud",opts);
    }
	
	void
    copyFile(char[] src, char[] dest)
    {
		version(Windows) exec("copy", fixPath(src), fixPath(dest));
		version(linux) exec("cp", fixPath(src), fixPath(dest));
	}
		
	void
    removeFile(char[] src)
    {
		version(Windows) exec("del", fixPath(src));
		version(linux) exec("rm", fixPath(src));
	}
	
	void
    moveFile(char[] src, char[] dest)
    {
		version(Windows) exec("move", fixPath(src), fixPath(dest));
		version(linux) exec("mv", fixPath(src), fixPath(dest));
	}

    char[]
    path(char[][] parts ...)
    {
        char[] result = "";
        if( parts.length > 0 )
            result = parts[0];
        for( uint i=1; i<parts.length; i++ )
            result = std.path.join(result, parts[i]);
        return fixPath(result);
    }
			
	void
    zip(char[] dest, char[][] targetFiles ...)
    {
		char[] destPath = fixPath(dest);
		ZipArchive archive;
				
		if( std.file.exists(destPath) )
        {
			archive = new ZipArchive(std.file.read(destPath));
		}
		else
        {
			archive = new ZipArchive();
		}
		
		foreach( filename; targetFiles )
        {
			auto member = new ArchiveMember();
			auto name = fixPath(filename);
			if( verboseCommands ) echof("Adding: %s", name);
			member.expandedData = cast(ubyte[]) std.file.read(name);
			member.name = name;
			archive.addMember(member);
		}
        
		std.file.write(destPath, archive.build());
		if( verboseCommands ) echof("Created Zip: %s",destPath);
	} 
}

