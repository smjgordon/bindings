
module snippets.text;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_text(Context cr, int width, int height)
{
    cr.selectFontFace("Sans", FontSlant.Normal, FontWeight.Bold);
    cr.setFontSize(0.35);

    cr.moveTo(0.04, 0.53);
    cr.showText("Hello");

    cr.moveTo(0.27, 0.65);
    cr.textPath("void");
    cr.setSourceRGB(0.5, 0.5, 1);
    cr.fillPreserve();
    cr.setSourceRGB(0, 0, 0);
    cr.lineWidth = 0.01;
    cr.stroke();

    // draw helping lines
    cr.setSourceRGBA(1, 0.2, 0.2, 0.6);
    cr.arc(0.04, 0.53, 0.02, 0, 2*PI);
    cr.arc(0.27, 0.65, 0.02, 0, 2*PI);
    cr.fill();
}

static this()
{
    snippets_hash["text"] = &snippet_text;
}

