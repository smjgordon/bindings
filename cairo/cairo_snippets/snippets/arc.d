
module snippets.arc;

private
{
    import std.math;
    import cairo.cairo;
    import snippets.common;
}

void snippet_arc(cairo_t* cr, int width, int height)
{
    double xc = 0.5;
    double yc = 0.5;
    double radius = 0.4;
    double angle1 = 45.0  * (PI/180.0);
    double angle2 = 180.0 * (PI/180.0);

    cairo_arc(cr, xc, yc, radius, angle1, angle2);
    cairo_stroke(cr);

    // draw helping lines
    cairo_set_source_rgba(cr, 1, 0.2, 0.2, 0.6);
    cairo_arc(cr, xc, yc, 0.05, 0, 2*PI);
    cairo_fill(cr);
    cairo_set_line_width(cr, 0.03);
    cairo_arc(cr, xc, yc, radius, angle1, angle1);
    cairo_line_to(cr, xc, yc);
    cairo_arc(cr, xc, yc, radius, angle2, angle2);
    cairo_line_to(cr, xc, yc);
    cairo_stroke(cr);
}

static this()
{
    snippets_hash["arc"] = &snippet_arc;
}

