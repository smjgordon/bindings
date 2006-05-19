
module snippets.set_line_join;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_set_line_join(Context cr, int width, int height)
{
    void drawShape(double y)
    {
        cr.moveTo(0.3, y);
        cr.relLineTo(0.2, -0.2);
        cr.relLineTo(0.2, 0.2);
    }

    cr.lineWidth = 0.16;
    drawShape(0.33);
    cr.lineJoin = LineJoin.Miter;
    cr.stroke();

    drawShape(0.63);
    cr.lineJoin = LineJoin.Bevel;
    cr.stroke();

    drawShape(0.93);
    cr.lineJoin = LineJoin.Round;
    cr.stroke();
}

static this()
{
    snippets_hash["set_line_join"] = &snippet_set_line_join;
}

