
module snippets.text_align_center;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_text_align_center(Context cr, int width, int height)
{
    TextExtents extents;
    auto utf8 = "cairo"c;
    double x, y;

    cr.selectFontFace("Sans", FontSlant.Normal, FontWeight.Normal);
    cr.setFontSize(0.2);
    extents = cr.textExtents(utf8);
    x = 0.5 - (extents.width/2 + extents.xBearing);
    y = 0.5 - (extents.height/2 + extents.yBearing);

    cr.moveTo(x, y);
    cr.showText(utf8);

    // draw helping lines
    cr.setSourceRGBA(1, 0.2, 0.2, 0.6);
    cr.arc(x, y, 0.05, 0, 2*PI);
    cr.fill();
    cr.moveTo(0.5, 0);
    cr.relLineTo(0, 1);
    cr.moveTo(0, 0.5);
    cr.relLineTo(1, 0);
    cr.stroke();
}

static this()
{
    snippets_hash["text_align_center"] = &snippet_text_align_center;
}

