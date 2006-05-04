
module snippets.set_line_cap;

private
{
    import std.math;
    import cairo.cairo;
    import snippets.common;
}

void snippet_set_line_cap(cairo_t* cr, int width, int height)
{
    cairo_set_line_width (cr, 0.12);
    cairo_set_line_cap  (cr, cairo_line_cap_t.CAIRO_LINE_CAP_BUTT); /* default */
    cairo_move_to (cr, 0.25, 0.2); cairo_line_to (cr, 0.25, 0.8);
    cairo_stroke (cr);
    cairo_set_line_cap  (cr, cairo_line_cap_t.CAIRO_LINE_CAP_ROUND);
    cairo_move_to (cr, 0.5, 0.2); cairo_line_to (cr, 0.5, 0.8);
    cairo_stroke (cr);
    cairo_set_line_cap  (cr, cairo_line_cap_t.CAIRO_LINE_CAP_SQUARE);
    cairo_move_to (cr, 0.75, 0.2); cairo_line_to (cr, 0.75, 0.8);
    cairo_stroke (cr);

    /* draw helping lines */
    cairo_set_source_rgb (cr, 1,0.2,0.2);
    cairo_set_line_width (cr, 0.01);
    cairo_move_to (cr, 0.25, 0.2); cairo_line_to (cr, 0.25, 0.8);
    cairo_move_to (cr, 0.5, 0.2);  cairo_line_to (cr, 0.5, 0.8);
    cairo_move_to (cr, 0.75, 0.2); cairo_line_to (cr, 0.75, 0.8);
    cairo_stroke (cr);
}

static this()
{
    snippets_hash["set_line_cap"] = &snippet_set_line_cap;
}

