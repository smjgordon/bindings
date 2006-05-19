
module snippets.curve_to;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_curve_to(Context cr, int width, int height)
{
    double x=0.1,  y=0.5;
    double x1=0.4, y1=0.9,
           x2=0.6, y2=0.1,
           x3=0.9, y3=0.5;

    cr.moveTo(x, y);
    cr.curveTo(x1, y1, x2, y2, x3, y3);
    cr.stroke();

    cr.setSourceRGBA(1, 0.2, 0.2, 0.6);
    cr.lineWidth = 0.03;
    cr.moveTo(x, y);    cr.lineTo(x1, y1);
    cr.moveTo(x2, y2);  cr.lineTo(x3, y3);
    cr.stroke();
}

static this()
{
    snippets_hash["curve_to"] = &snippet_curve_to;
}

