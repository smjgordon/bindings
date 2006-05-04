
module snippets.curve_to;

private
{
    import std.math;
    import cairo.cairo;
    import snippets.common;
}

void snippet_curve_to(cairo_t* cr, int width, int height)
{
    double x=0.1,  y=0.5;
    double x1=0.4, y1=0.9,
           x2=0.6, y2=0.1,
           x3=0.9, y3=0.5;

    cairo_move_to (cr,  x, y);
    cairo_curve_to (cr, x1, y1, x2, y2, x3, y3);

    cairo_stroke (cr);

    cairo_set_source_rgba (cr, 1,0.2,0.2,0.6);
    cairo_set_line_width (cr, 0.03);
    cairo_move_to (cr,x,y);   cairo_line_to (cr,x1,y1);
    cairo_move_to (cr,x2,y2); cairo_line_to (cr,x3,y3);
    cairo_stroke (cr);
}

static this()
{
    snippets_hash["curve_to"] = &snippet_curve_to;
}

