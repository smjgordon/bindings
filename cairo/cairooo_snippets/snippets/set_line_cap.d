
module snippets.set_line_cap;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_set_line_cap(Context cr, int width, int height)
{
    cr.lineWidth = 0.12;
    cr.lineCap = LineCap.Butt;
    cr.moveTo(0.25, 0.2);   cr.lineTo(0.25, 0.8);
    cr.stroke();
    cr.lineCap = LineCap.Round;
    cr.moveTo(0.5, 0.2);    cr.lineTo(0.5, 0.8);
    cr.stroke();
    cr.lineCap = LineCap.Square;
    cr.moveTo(0.75, 0.2);   cr.lineTo(0.75, 0.8);
    cr.stroke();

    // draw helping lines
    cr.setSourceRGB(1, 0.2, 0.2);
    cr.lineWidth = 0.01;
    cr.moveTo(0.25, 0.2);   cr.lineTo(0.25, 0.8);
    cr.moveTo(0.5, 0.2);    cr.lineTo(0.5, 0.8);
    cr.moveTo(0.75, 0.2);   cr.lineTo(0.75, 0.8);
    cr.stroke();
}

static this()
{
    snippets_hash["set_line_cap"] = &snippet_set_line_cap;
}

