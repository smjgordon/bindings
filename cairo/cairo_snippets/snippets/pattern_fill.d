
module snippets.pattern_fill;

/* Note:
 * This snippet apparently does nothing.  I have no idea why; it is
 * translated directly from the code on the cairo site.  Incidentally,
 * the output image on the cairo site is empty as well, so either the
 * original code is wrong, or cairo has a bug in it that this exposes...
 */

private
{
    import std.math;
    import std.random;
    import cairo.cairo;
    import snippets.common;

    const X_FUZZ = 0.08;
    const Y_FUZZ = 0.08;

    const X_INNER_RADIUS = 0.3;
    const Y_INNER_RADIUS = 0.2;

    const X_OUTER_RADIUS = 0.45;
    const Y_OUTER_RADIUS = 0.35;

    const SPIKES = 10;

    double drand()
    {
        return cast(double)rand() / cast(double)uint.max;
    }
}

void snippet_pattern_fill(cairo_t* cr, int width, int height)
{
    double x,y;
    char[] text = "KAPOW!";
    cairo_text_extents_t extents;

    // Un-normalize the context...
    cairo_scale(cr, 1./width, 1./height);

    rand_seed(45, 0);
    cairo_set_line_width(cr, 0.01);

    for( int i = 0; i < SPIKES * 2; i++ )
    {
        x = 0.5 + cos(PI*i/SPIKES) * X_INNER_RADIUS + drand()*X_FUZZ;
        y = 0.5 + sin(PI*i/SPIKES) * Y_INNER_RADIUS + drand()*Y_FUZZ;

        if( i == 0 )
            cairo_move_to(cr, x, y);
        else
            cairo_line_to(cr, x, y);

        i++;

        x = 0.5 + cos(PI*i/SPIKES) * X_OUTER_RADIUS + drand()*X_FUZZ;
        y = 0.5 + sin(PI*i/SPIKES) * Y_OUTER_RADIUS + drand()*Y_FUZZ;

        cairo_line_to(cr, x, y);
    }

    cairo_close_path(cr);
    cairo_stroke(cr);

    cairo_select_font_face(cr, "Sans",
            cairo_font_slant_t.CAIRO_FONT_SLANT_NORMAL,
            cairo_font_weight_t.CAIRO_FONT_WEIGHT_BOLD);
    
    cairo_move_to(cr, x, y);
    cairo_text_path(cr, text);

    cairo_set_font_size(cr, 0.2);
    cairo_text_extents(cr, text, &extents);
    x = 0.5 - (extents.width/2 + extents.x_bearing);
    y = 0.5 - (extents.height/2 + extents.y_bearing);

    cairo_set_source_rgb(cr, 1, 1, 0.5);
    cairo_fill(cr);

    cairo_move_to(cr, x, y);
    cairo_text_path(cr, text);
    cairo_set_source_rgb(cr, 0, 0, 0);
    cairo_stroke(cr);
}

static this()
{
    snippets_hash["pattern_fill"] = &snippet_pattern_fill;
}

