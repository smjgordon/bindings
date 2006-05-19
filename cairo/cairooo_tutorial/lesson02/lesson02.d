/*
    cairooo tutorial, lesson 2
    User coordinates
    
    Written by Daniel Keep, 2006.
    Released into the Public Domain.
    
    Welcome to the second cairooo tutorial.  This time, we're going to cover a
    bit more on user coordinates.  It's a short tutorial, but important.

    First of all, let's get import what we need and get on to the main
    function.
*/
import cairooo.all;
import cairooo.png.all;

import std.math;
import std.stdio;

void main()
{
    try
    {
        Cairo.load();
        CairoPNG.load();
    }
    catch( CairoLoaderException e )
    {
        writefln("Sorry; couldn't load the cairo library!");
        return;
    }
/*
    Woah, that's new.  Instead of using a static constructor, this time we're
    manually loading the cairooo packages.  Not only that, but we've set up a
    very basic (but functional) handler to catch any exceptions that might be
    thrown whilst trying to load the cairo library.

    This handler is very simplistic: it doesn't say *why* it failed to load,
    just that it did.  In a real program, you'd probably want to be a little
    more sophisticated, but for our purposes, it's enough.
*/
    auto ImageSurface surface =
        new ImageSurface(Format.ARGB32, 256, 256);
    auto Context cr = new Context(surface);
/*
    Again, we've set up an image 256 x 256, and created a context.
*/
    cr.rectangle(0, 0, 256, 256);
    cr.setSourceRGBA(1, 1, 1, 0);
    cr.operator = Operator.Clear;
    cr.fill();
/*
    Here, we clear it.
*/
    cr.scale(256,256);
/*
    This line is new: what we're doing is we are scaling the context by 256
    units in both directions.  So what does this mean in practice?

    Pretend that you are my cairo context, and I say to you:

        cr.scale(3,3);

    From now on, whenever I tell you to draw something, you have to draw it
    three times larger than I told you to.  So if I told you to draw a box
    that was 1 unit by 1 unit, you would draw a box that was really 3 units by
    3 units.

    This is what is known as a user space to device space transformation.  The
    values I we are sending to cairo are "user space" values; because we are
    the "user".  The values that cairo uses when it performs its drawing
    operations on the underlying surface are "device space" values.

    So, in practical terms, the above line causes everything we send to cairo
    to come out 256 times larger.  We'll discuss why this is handy later on.
    
    For now, just keep in mind that since our surface is 256 x 256, and
    everything we draw is coming out 256 times larger, then if we draw a
    square 1 unit by 1 unit, it will cover the entire surface!
    
    Now, let's do some more setup.
*/
    cr.lineWidth = 0.015;
    cr.setSourceRGB(0, 0, 0);
    cr.operator = Operator.Over;
/*
    Notice that we're using a finer line width this time.  This is because
    when we tell cairo to scale everything by 256, we mean *everything*,
    including how thick lines are!

    All done; we're ready to draw.  So let's draw something!
*/
    cr.arc(0.5, 0.5, 0.47, 0, 2*PI);
    cr.stroke();
    cr.arc(0.5 - 0.23, 0.5 - 0.23, 0.06, 0, 2*PI);
    cr.stroke();
    cr.arc(0.5 + 0.23, 0.5 - 0.23, 0.06, 0, 2*PI);
    cr.stroke();
    cr.arc(0.5, 0.5, 0.35, 0, PI);
    cr.stroke();
/*
    Again, notice that we're using floating point values for our
    coordinates.  This is because in user-space, our surface is only 1 unit by
    1 unit, so we have to use fractional values.

    Also, you hopefully recognise this as our smiley face from last lesson
    :)
*/
    PNGSurface.writeToPNG(surface, "lesson02.png");
/*
    And finally, we write it out.  Run the program and check the output.
    You'll see a smiley face that looks a lot like our last one.

    So what did we actually *do* in this lesson?  Well, we moved from using
    integer coordinates to using fractional ones.  And this is more important
    than you may think.

    Step back for a second, and imagine you are writing code to draw some
    complex shape on a surface.  You don't create the surface; you're just
    provided it.  Let's say you write your code to draw this shape 256 pixels
    by 256 pixels.

    This is all well and good if you are given a surface that's 256 pixels by
    256 pixels... but what if you're given one that is 512 pixels square?
    Then your shape will only fill the topleft corner.

    Even worse, what if you're given one that's too small?  If it's only 128
    pixels square, then you'll end up losing three quarters of your output!

    That's why it's common practice to make your context, irrespective of how
    big the underlying surface is, some standardised size.  Lots of people use
    one by one squares.  Some prefer to use larger units like 100 x 100.  The
    key thing is that you write code that doesn't depend on some fixed
    physical size.

    Want a real world example?  Take any 3D game.  Look at a flat wall with
    some fancy texture on it.  What units do you suppose they use to tell the
    game's engine which part of the texture to render?

    They use units in a 1 unit by 1 unit square.

    So even if it looks a bit odd, you're in good company :)

    Next lesson, we'll look at filling things in, and using different colours.

        -- Daniel Keep
*/
}

