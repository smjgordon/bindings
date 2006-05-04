
module snippets.gradient;

private
{
    import std.math;
    import cairo.cairo;
    import snippets.common;
}

void snippet_gradient(cairo_t* cr, int width, int height)
{
    cairo_pattern_t *pat;

    pat = cairo_pattern_create_linear (0.0, 0.0,  0.0, 1.0);
    {
        scope(exit) cairo_pattern_destroy(pat);
        cairo_pattern_add_color_stop_rgba (pat, 1, 0, 0, 0, 1);
        cairo_pattern_add_color_stop_rgba (pat, 0, 1, 1, 1, 1);
        cairo_rectangle (cr, 0, 0, 1, 1);
        cairo_set_source (cr, pat);
        cairo_fill (cr);
    }

    pat = cairo_pattern_create_radial (0.45, 0.4, 0.1,
                                       0.4,  0.4, 0.5);
    {
        scope(exit) cairo_pattern_destroy(pat);
        cairo_pattern_add_color_stop_rgba (pat, 0, 1, 1, 1, 1);
        cairo_pattern_add_color_stop_rgba (pat, 1, 0, 0, 0, 1);
        cairo_set_source (cr, pat);
        cairo_arc (cr, 0.5, 0.5, 0.3, 0, 2 * PI);
        cairo_fill (cr);
    }
}

static this()
{
    snippets_hash["gradient"] = &snippet_gradient;
}

