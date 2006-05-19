
module snippets.text_extents;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_text_extents(Context cr, int width, int height)
{
    TextExtents extents;
    char[] utf8 = "cairo";
    double x, y;

    cr.selectFontFace("Sans", FontSlant.Normal, FontWeight.Normal);
    cr.setFontSize(0.4);
    extents = cr.textExtents(utf8);

    x = 0.1; y = 0.6;

    cr.moveTo(x, y);
    cr.showText(utf8);

    // draw helping lines
    cr.setSourceRGBA(1, 0.2, 0.2, 0.6);
    cr.arc(x, y, 0.05, 0, 2*PI);
    cr.fill();
    cr.moveTo(x, y);
    cr.relLineTo(0, -extents.height);
    cr.relLineTo(extents.width, 0);
    cr.relLineTo(extents.xBearing, -extents.yBearing);
    cr.stroke();
}

static this()
{
    snippets_hash["text_extents"] = &snippet_text_extents;
}

