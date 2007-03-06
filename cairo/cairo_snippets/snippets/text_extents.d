
module snippets.text_extents;

private
{
    import std.math;
    import std.string;
    import cairo.cairo;
    import snippets.common;
}

void snippet_text_extents(cairo_t* cr, int width, int height)
{
    cairo_text_extents_t extents;

    char[] utf8 = "cairo";
    double x,y;

    cairo_select_font_face (cr, "Sans",
        cairo_font_slant_t.CAIRO_FONT_SLANT_NORMAL,
        cairo_font_weight_t.CAIRO_FONT_WEIGHT_NORMAL);

    cairo_set_font_size (cr, 0.4);
    cairo_text_extents (cr, toStringz(utf8), &extents);

    x=0.1;
    y=0.6;

    cairo_move_to (cr, x,y);
    cairo_show_text (cr, toStringz(utf8));

    /* draw helping lines */
    cairo_set_source_rgba (cr, 1,0.2,0.2, 0.6);
    cairo_arc (cr, x, y, 0.05, 0, 2*PI);
    cairo_fill (cr);
    cairo_move_to (cr, x,y);
    cairo_rel_line_to (cr, 0, -extents.height);
    cairo_rel_line_to (cr, extents.width, 0);
    cairo_rel_line_to (cr, extents.x_bearing, -extents.y_bearing);
    cairo_stroke (cr);
}

static this()
{
    snippets_hash["text_extents"] = &snippet_text_extents;
}

