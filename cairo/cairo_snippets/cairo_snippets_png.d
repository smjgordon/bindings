
import std.stdio;
import std.string;

import cairo.cairo;
import cairo.png.cairo_png;

import snippets.all;
import snippets.common;

// Some constants
const IMAGE_WIDTH = 256;
const IMAGE_HEIGHT = 256;

const LINE_WIDTH = 0.04;

const OUTPUT_PATH = "output/%s.png";

// Static constructor; use this to load up the cairo
// binding.
static this()
{
    cairo_load();
    cairo_png_load();
}

void main(char[][] argv)
{
    writefln("cairo_snippets_png");
    writefln("Using libcairo version %s", toString(cairo_version_string()));
    
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
    
    cairo_t* cr;
    cairo_surface_t* surface;
    
    // Create a new surface.
    surface = cairo_image_surface_create(
            cairo_format_t.CAIRO_FORMAT_ARGB32, IMAGE_WIDTH, IMAGE_HEIGHT);
    cr = cairo_create(surface);

    // Ensure surface and context are destroyed when we leave this
    // function, even if we throw an exception.
    scope(exit)
    {
        cairo_destroy(cr);
        cairo_surface_destroy(surface);
    }

    // Scale it to a unit square, and set the line width.
    cairo_scale(cr, IMAGE_WIDTH, IMAGE_HEIGHT);
    cairo_set_line_width(cr, LINE_WIDTH);

    // Clear the background
    cairo_rectangle(cr, 0, 0, 1, 1);
    cairo_set_source_rgba(cr, 1, 1, 1, 0);
    cairo_set_operator(cr, cairo_operator_t.CAIRO_OPERATOR_CLEAR);
    cairo_fill(cr);

    // Reset the context for the snippet
    cairo_set_source_rgb(cr, 0, 0, 0);
    cairo_set_operator(cr, cairo_operator_t.CAIRO_OPERATOR_OVER);

    // Call the snippet.
    cairo_save(cr);
    snippet(cr, IMAGE_WIDTH, IMAGE_HEIGHT);
    cairo_restore(cr);

    // Write the results to disk.
    cairo_surface_write_to_png(surface, toStringz(OUTPUT_PATH.format(name)));

    writefln("Done.");
}

