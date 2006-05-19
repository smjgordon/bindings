
module snippets.arc_negative;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_arc_negative(Context cr, int width, int height)
{
    double xc = 0.5;
    double yc = 0.5;
    double radius = 0.4;
    double angle1 = 45.0  * (PI/180.0);
    double angle2 = 180.0 * (PI/180.0);

    cr.arcNegative(xc, yc, radius, angle1, angle2);
    cr.stroke();
    
    // draw helping lines
    cr.setSourceRGBA(1, 0.2, 0.2, 0.6);
    cr.arc(xc, yc, 0.05, 0, 2*PI);
    cr.fill();
    cr.lineWidth = 0.03;
    cr.arc(xc, yc, radius, angle1, angle1);
    cr.lineTo(xc, yc);
    cr.arc(xc, yc, radius, angle2, angle2);
    cr.lineTo(xc, yc);
    cr.stroke();
}

static this()
{
    snippets_hash["arc_negative"] = &snippet_arc_negative;
}

