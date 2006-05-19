
module snippets.clip;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_clip(Context cr, int width, int height)
{
    cr.arc(0.5, 0.5, 0.3, 0, 2*PI);
    cr.clip();

    cr.newPath(); // current path is not consumed by Context.clip()
    cr.rectangle(0, 0, 1, 1);
    cr.fill();
    cr.setSourceRGB(0, 1, 0);
    cr.moveTo(0, 0);
    cr.lineTo(1, 1);
    cr.moveTo(1, 0);
    cr.lineTo(0, 1);
    cr.stroke();
}

static this()
{
    snippets_hash["clip"] = &snippet_clip;
}

