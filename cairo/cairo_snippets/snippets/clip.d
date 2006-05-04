
module snippets.clip;

private
{
    import std.math;
    import cairo.cairo;
    import snippets.common;
}

void snippet_clip(cairo_t* cr, int width, int height)
{
    cairo_arc (cr, 0.5, 0.5, 0.3, 0, 2 * PI);
    cairo_clip (cr);

    cairo_new_path (cr);  /* current path is not
                             consumed by cairo_clip() */
    cairo_rectangle (cr, 0, 0, 1, 1);
    cairo_fill (cr);
    cairo_set_source_rgb (cr, 0, 1, 0);
    cairo_move_to (cr, 0, 0);
    cairo_line_to (cr, 1, 1);
    cairo_move_to (cr, 1, 0);
    cairo_line_to (cr, 0, 1);
    cairo_stroke (cr);
}

static this()
{
    snippets_hash["clip"] = &snippet_clip;
}

