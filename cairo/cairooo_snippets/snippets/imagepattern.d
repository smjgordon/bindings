
module snippets.imagepattern;

private
{
    import std.math;
    import cairooo.all;
    import cairooo.png.all;
    import snippets.common;
}

void snippet_imagepattern(Context cr, int width, int height)
{
    auto PNGSurface image = new PNGSurface("data/romedalen.png");
    int w = image.width;
    int h = image.height;

    auto SurfacePattern pattern = SurfacePattern.create(image);
    pattern.extend = Extend.Repeat;
    pattern.matrix = Matrix.initScale(w*5, h*5);

    cr.translate(0.5, 0.5);
    cr.rotate(PI/4);
    cr.scale(1/sqrt(2.), 1/sqrt(2.));
    cr.translate(-0.5, -0.5);

    cr.setSource(pattern);

    cr.rectangle(0, 0, 1.0, 1.0);
    cr.fill();
}

static this()
{
    snippets_hash["imagepattern"] = &snippet_imagepattern;
}

