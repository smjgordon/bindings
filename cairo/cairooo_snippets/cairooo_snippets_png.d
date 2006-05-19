
import std.stdio;
import std.string;

import cairooo.all;
import cairooo.png.all;

import snippets.all;
import snippets.common;

// Some constants
const IMAGE_WIDTH = 256;
const IMAGE_HEIGHT = 256;

const LINE_WIDTH = 0.04;

const OUTPUT_PATH = "output/%s.png";

static this()
{
    Cairo.load();
    CairoPNG.load();
}

void main(char[][] argv)
{
    writefln("cairooo_snippets_png");
    writefln("Using libcairo version %s", Cairo.cairoVersionString);
    
    if( argv.length > 1 )
    {
        foreach( n, arg ; argv )
        {
            if( n == 0 ) continue;

            if( arg in snippets_hash )
                do_snippet(arg, snippets_hash[arg]);
            else
                throw new Exception("Unknown snippet \"%s\".".format(arg));
        }
    }
    else
    {
        auto keys = snippets_hash.keys.dup;
        keys.sort;
        
        foreach( k ; keys )
            do_snippet(k, snippets_hash[k]);
    }
}

void do_snippet(char[] name, snippet_fn snippet)
{
    writef("Running snippet \"%s\"... ", name);
    
    // Create a new surface.
    auto ImageSurface surface = new ImageSurface(Format.ARGB32, IMAGE_WIDTH,
            IMAGE_HEIGHT);
    auto Context cr = new Context(surface);

    // Scale it to a unit square, and set the line width.
    cr.scale(IMAGE_WIDTH, IMAGE_HEIGHT);
    cr.lineWidth = LINE_WIDTH;

    // Clear the background
    cr.rectangle(0, 0, 1, 1);
    cr.setSourceRGBA(1, 1, 1, 0);
    cr.operator = Operator.Clear;
    cr.fill();

    // Reset the context for the snippet
    cr.setSourceRGB(0, 0, 0);
    cr.operator = Operator.Over;

    // Call the snippet.
    cr.save();
    snippet(cr, IMAGE_WIDTH, IMAGE_HEIGHT);
    cr.restore();

    // Write the results to disk.
    PNGSurface.writeToPNG(surface, OUTPUT_PATH.format(name));

    writefln("Done.");
}

