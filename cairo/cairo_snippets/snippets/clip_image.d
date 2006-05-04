
module snippets.clip_image;

private
{
    import std.math;
    import cairo.cairo;
    import cairo.png.cairo_png;
    import snippets.common;
}

void snippet_clip_image(cairo_t* cr, int width, int height)
{
    int w, h;
    cairo_surface_t *image;

    cairo_arc (cr, 0.5, 0.5, 0.3, 0, 2*PI);
    cairo_clip (cr);
    cairo_new_path (cr); /* path not consumed by clip()*/

    image = cairo_image_surface_create_from_png ("data/romedalen.png");
    scope(exit) cairo_surface_destroy(image);
    
    w = cairo_image_surface_get_width (image);
    h = cairo_image_surface_get_height (image);

    cairo_scale (cr, 1.0/w, 1.0/h);

    cairo_set_source_surface (cr, image, 0, 0);
    cairo_paint (cr);
}

static this()
{
    snippets_hash["clip_image"] = &snippet_clip_image;
}

