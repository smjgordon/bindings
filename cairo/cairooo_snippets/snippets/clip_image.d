
module snippets.clip_image;

private
{
    import std.math;
    import cairooo.all;
    import cairooo.png.all;
    import snippets.common;
}

void snippet_clip_image(Context cr, int width, int height)
{
    cr.arc(0.5, 0.5, 0.3, 0, 2*PI);
    cr.clip();
    cr.newPath(); // path not consumed by Context.clip()

    // We use 'auto' to ensure that the surface is destroyed when we leave
    // this scope.
    auto PNGSurface image = new PNGSurface("data/romedalen.png");
    
    cr.scale(1.0/image.width, 1.0/image.height);

    cr.setSource(image, 0, 0);
    cr.paint();
}

static this()
{
    snippets_hash["clip_image"] = &snippet_clip_image;
}

