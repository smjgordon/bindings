
module snippets.imagepattern;

private
{
    import std.math;
    import cairo.cairo;
    import cairo.png.cairo_png;
    import snippets.common;
}

void snippet_imagepattern(cairo_t* cr, int width, int height)
{
    int w, h;
    cairo_surface_t *image;
    cairo_pattern_t *pattern;
    cairo_matrix_t   matrix;

    image = cairo_image_surface_create_from_png ("data/romedalen.png");
    scope(exit) cairo_surface_destroy(image);
    
    w = cairo_image_surface_get_width (image);
    h = cairo_image_surface_get_height (image);

    pattern = cairo_pattern_create_for_surface (image);
    scope(exit) cairo_pattern_destroy(pattern);

    cairo_pattern_set_extend (pattern, cairo_extend_t.CAIRO_EXTEND_REPEAT);

    cairo_translate (cr, 0.5, 0.5);
    cairo_rotate (cr, PI / 4);
    cairo_scale (cr, 1 / sqrt (2.), 1 / sqrt (2.));
    cairo_translate (cr, - 0.5, - 0.5);

    cairo_matrix_init_scale (&matrix, w * 5., h * 5.); 
    cairo_pattern_set_matrix (pattern, &matrix);

    cairo_set_source (cr, pattern);

    cairo_rectangle (cr, 0, 0, 1.0, 1.0);
    cairo_fill (cr);
}

static this()
{
    snippets_hash["imagepattern"] = &snippet_imagepattern;
}

