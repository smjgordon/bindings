
module snippets.set_line_join;

private
{
    import std.math;
    import cairo.cairo;
    import snippets.common;
}

void snippet_set_line_join(cairo_t* cr, int width, int height)
{
    cairo_set_line_width (cr, 0.16);
    cairo_move_to (cr, 0.3, 0.33);
    cairo_rel_line_to (cr, 0.2, -0.2);
    cairo_rel_line_to (cr, 0.2, 0.2);
    cairo_set_line_join (cr, cairo_line_join_t.CAIRO_LINE_JOIN_MITER); /* default */
    cairo_stroke (cr);

    cairo_move_to (cr, 0.3, 0.63);
    cairo_rel_line_to (cr, 0.2, -0.2);
    cairo_rel_line_to (cr, 0.2, 0.2);
    cairo_set_line_join (cr, cairo_line_join_t.CAIRO_LINE_JOIN_BEVEL);
    cairo_stroke (cr);

    cairo_move_to (cr, 0.3, 0.93);
    cairo_rel_line_to (cr, 0.2, -0.2);
    cairo_rel_line_to (cr, 0.2, 0.2);
    cairo_set_line_join (cr, cairo_line_join_t.CAIRO_LINE_JOIN_ROUND);
    cairo_stroke (cr);
}

static this()
{
    snippets_hash["set_line_join"] = &snippet_set_line_join;
}

