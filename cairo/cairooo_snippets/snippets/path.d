
module snippets.path;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_path(Context cr, int width, int height)
{
    cr.moveTo(0.5, 0.1);
    cr.lineTo(0.9, 0.9);
    cr.relLineTo(-0.4, 0.0);
    cr.curveTo(0.2, 0.9, 0.2, 0.5, 0.5, 0.5);

    cr.stroke();
}

static this()
{
    snippets_hash["path"] = &snippet_path;
}

