
module snippets.fill_and_stroke;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_fill_and_stroke(Context cr, int width, int height)
{
    cr.moveTo(0.5, 0.1);
    cr.lineTo(0.9, 0.9);
    cr.relLineTo(-0.4, 0.0);
    cr.curveTo(0.2, 0.9, 0.2, 0.5, 0.5, 0.5);
    cr.closePath();

    cr.setSourceRGB(0, 0, 1);
    cr.fillPreserve();
    cr.setSourceRGB(0, 0, 0);
    cr.stroke();
}

static this()
{
    snippets_hash["fill_and_stroke"] = &snippet_fill_and_stroke;
}

