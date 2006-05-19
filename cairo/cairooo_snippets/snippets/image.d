
module snippets.image;

private
{
    import std.math;
    import cairooo.all;
    import cairooo.png.all;
    import snippets.common;
}

void snippet_image(Context cr, int width, int height)
{
    auto PNGSurface image = new PNGSurface("data/romedalen.png");

    int w = image.width;
    int h = image.height;

    cr.translate(0.5, 0.5);
    cr.rotate(45*PI/180);
    cr.scale(1.0/w, 1.0/h);
    cr.translate(-0.5*w, -0.5*h);

    cr.setSource(image, 0, 0);
    cr.paint();
}

static this()
{
    snippets_hash["image"] = &snippet_image;
}

