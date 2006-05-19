
module snippets.curve_rectangle;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_curve_rectangle(Context cr, int width, int height)
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
            cr.moveTo   (x0, (y0 + y1)/2);
            cr.curveTo  (x0 ,y0, x0, y0, (x0 + x1)/2, y0);
            cr.curveTo  (x1, y0, x1, y0, x1, (y0 + y1)/2);
            cr.curveTo  (x1, y1, x1, y1, (x1 + x0)/2, y1);
            cr.curveTo  (x0, y1, x0, y1, x0, (y0 + y1)/2);
        } else {
            cr.moveTo   (x0, y0 + radius);
            cr.curveTo  (x0 ,y0, x0, y0, (x0 + x1)/2, y0);
            cr.curveTo  (x1, y0, x1, y0, x1, y0 + radius);
            cr.lineTo   (x1 , y1 - radius);
            cr.curveTo  (x1, y1, x1, y1, (x1 + x0)/2, y1);
            cr.curveTo  (x0, y1, x0, y1, x0, y1- radius);
        }
    } else {
        if (rect_height/2<radius) {
            cr.moveTo   (x0, (y0 + y1)/2);
            cr.curveTo  (x0 , y0, x0 , y0, x0 + radius, y0);
            cr.lineTo   (x1 - radius, y0);
            cr.curveTo  (x1, y0, x1, y0, x1, (y0 + y1)/2);
            cr.curveTo  (x1, y1, x1, y1, x1 - radius, y1);
            cr.lineTo   (x0 + radius, y1);
            cr.curveTo  (x0, y1, x0, y1, x0, (y0 + y1)/2);
        } else {
            cr.moveTo   (x0, y0 + radius);
            cr.curveTo  (x0 , y0, x0 , y0, x0 + radius, y0);
            cr.lineTo   (x1 - radius, y0);
            cr.curveTo  (x1, y0, x1, y0, x1, y0 + radius);
            cr.lineTo   (x1 , y1 - radius);
            cr.curveTo  (x1, y1, x1, y1, x1 - radius, y1);
            cr.lineTo   (x0 + radius, y1);
            cr.curveTo  (x0, y1, x0, y1, x0, y1- radius);
        }
    }
    cr.closePath();

    cr.setSourceRGB(0.5, 0.5, 1);
    cr.fillPreserve();
    cr.setSourceRGBA(0.5, 0, 0, 0.5);
    cr.stroke();
}

static this()
{
    snippets_hash["curve_rectangle"] = &snippet_curve_rectangle;
}

