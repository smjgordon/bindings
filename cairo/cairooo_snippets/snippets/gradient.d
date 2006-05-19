
module snippets.gradient;

private
{
    import std.math;
    import cairooo.all;
    import snippets.common;
}

void snippet_gradient(Context cr, int width, int height)
{
    {
        auto Gradient pat = LinearGradient.create(0.0, 0.0, 0.0, 1.0);
        pat.addColorStopRGBA(1, 0, 0, 0, 1);
        pat.addColorStopRGBA(0, 1, 1, 1, 1);
        cr.rectangle(0, 0, 1, 1);
        cr.setSource(pat);
        cr.fill();
    }
    {
        auto Gradient pat = RadialGradient.create(0.45, 0.4, 0.1,
                                                  0.4,  0.4, 0.5);
        pat.addColorStopRGBA(0, 1, 1, 1, 1);
        pat.addColorStopRGBA(1, 0, 0, 0, 1);
        cr.setSource(pat);
        cr.arc(0.5, 0.5, 0.3, 0, 2*PI);
        cr.fill();
    }
}

static this()
{
    snippets_hash["gradient"] = &snippet_gradient;
}

