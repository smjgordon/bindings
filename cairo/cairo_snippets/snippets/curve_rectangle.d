
module snippets.curve_rectangle;

private
{
    import std.math;
    import cairo.cairo;
    import snippets.common;
}

void snippet_curve_rectangle(cairo_t* cr, int width, int height)
{
    /* a custom shape, that could be wrapped in a function */
    double x0	   = 0.1,   /*< parameters like cairo_rectangle */
           y0	   = 0.1,
           rect_width  = 0.8,
           rect_height = 0.8,
           radius = 0.4;   /*< and an approximate curvature radius */

    double x1,y1;

    x1=x0+rect_width;
    y1=y0+rect_height;
    if (!rect_width || !rect_height)
        return;
    if (rect_width/2<radius) {
        if (rect_height/2<radius) {
            cairo_move_to  (cr, x0, (y0 + y1)/2);
            cairo_curve_to (cr, x0 ,y0, x0, y0, (x0 + x1)/2, y0);
            cairo_curve_to (cr, x1, y0, x1, y0, x1, (y0 + y1)/2);
            cairo_curve_to (cr, x1, y1, x1, y1, (x1 + x0)/2, y1);
            cairo_curve_to (cr, x0, y1, x0, y1, x0, (y0 + y1)/2);
        } else {
            cairo_move_to  (cr, x0, y0 + radius);
            cairo_curve_to (cr, x0 ,y0, x0, y0, (x0 + x1)/2, y0);
            cairo_curve_to (cr, x1, y0, x1, y0, x1, y0 + radius);
            cairo_line_to (cr, x1 , y1 - radius);
            cairo_curve_to (cr, x1, y1, x1, y1, (x1 + x0)/2, y1);
            cairo_curve_to (cr, x0, y1, x0, y1, x0, y1- radius);
        }
    } else {
        if (rect_height/2<radius) {
            cairo_move_to  (cr, x0, (y0 + y1)/2);
            cairo_curve_to (cr, x0 , y0, x0 , y0, x0 + radius, y0);
            cairo_line_to (cr, x1 - radius, y0);
            cairo_curve_to (cr, x1, y0, x1, y0, x1, (y0 + y1)/2);
            cairo_curve_to (cr, x1, y1, x1, y1, x1 - radius, y1);
            cairo_line_to (cr, x0 + radius, y1);
            cairo_curve_to (cr, x0, y1, x0, y1, x0, (y0 + y1)/2);
        } else {
            cairo_move_to  (cr, x0, y0 + radius);
            cairo_curve_to (cr, x0 , y0, x0 , y0, x0 + radius, y0);
            cairo_line_to (cr, x1 - radius, y0);
            cairo_curve_to (cr, x1, y0, x1, y0, x1, y0 + radius);
            cairo_line_to (cr, x1 , y1 - radius);
            cairo_curve_to (cr, x1, y1, x1, y1, x1 - radius, y1);
            cairo_line_to (cr, x0 + radius, y1);
            cairo_curve_to (cr, x0, y1, x0, y1, x0, y1- radius);
        }
    }
    cairo_close_path (cr);

    cairo_set_source_rgb (cr, 0.5,0.5,1);
    cairo_fill_preserve (cr);
    cairo_set_source_rgba (cr, 0.5, 0, 0, 0.5);
    cairo_stroke (cr);
}

static this()
{
    snippets_hash["curve_rectangle"] = &snippet_curve_rectangle;
}

