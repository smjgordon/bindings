/*
    cairooo tutorial, lesson 3
    Filling and colours
    
    Written by Daniel Keep, 2006.
    Released into the Public Domain.
    
    It's time for the third cariooo tutorial.  In this installment, I'm going
    to show you how to fill your shapes in, and how to tell cairo to use
    different colours.

    So, let's get down to brass tacks...
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

    auto ImageSurface surface =
        new ImageSurface(Format.ARGB32, 256, 256);
    auto Context cr = new Context(surface);
    
    cr.scale(256,256);
    cr.rectangle(0, 0, 1, 1);
    cr.setSourceRGBA(1, 1, 1, 0);
    cr.operator = Operator.Clear;
    cr.fill();

    cr.lineWidth = 0.015;
    cr.setSourceRGB(0, 0, 0);
    cr.operator = Operator.Over;
/*
    The above should be old-news for you.  One thing to note is that we've
    switched the order of the calls to scale and rectangle.  If you're going
    to use a "standard" coordinate system, it's best to be consistent across
    all your code, or you might end up confused.

    Now, it's time to start drawing.  Once again, we're going to use Mr.
    Smiley Face, so let's start with the large circle first.
*/
    cr.arc(0.5, 0.5, 0.47, 0, 2*PI);
    cr.setSourceRGB(1, 1, 0);
    cr.fill();
/*
    Say hello to the fill method.  This fun little guy will take whatever
    shape you have described to cairo, and fill it with the colour of your
    choosing.  In this case, we changed the colour from black to yellow, and
    then filled our circle in.

    For those that are wondering what part of that says "yellow", the
    arguments to setSourceRGB are red component, the green component and the
    blue component, each ranging from 0 to 1.  In this case, full red + full
    green = yellow.

    If you don't know about RGB colours, then you might want to look it up.
    TODO: Find explanation.  Wikipedia?

    So, now that we've filled his head, let's put a line around it.
*/
    cr.arc(0.5, 0.5, 0.47, 0, 2*PI);
    cr.setSourceRGB(0, 0, 0);
    cr.stroke();
/*
    Notice that we had to describe the path again.  That's because whenever
    you call fill or stroke, it consumes the path you've described.

    Also, we had to do our stroke *after* we filled, or our fill would have
    been drawn over the top of our nice black line!

    Of course, you can reverse them if that's the effect your after...

    Next, let's put his left eye in.
*/
    cr.arc(0.5 - 0.23, 0.5 - 0.23, 0.06, 0, 2*PI);
    cr.setSourceRGB(1, 1, 1);
    cr.fillPreserve();
    cr.setSourceRGB(0, 0, 0);
    cr.stroke();
/*
    What happened here; we only described the path once!  In this case, we
    used a special version of fill: fillPreserve.  This will fill the shape
    you've described, but *without* consuming it.  That means we can call
    stroke without have to re-describe the shape: very handy!
*/
    cr.arc(0.5 + 0.23, 0.5 - 0.23, 0.06, 0, 2*PI);
    cr.setSourceRGB(1, 1, 1);
    cr.fillPreserve();
    cr.setSourceRGB(0, 0, 0);
    cr.stroke();
/*
    That's his other eye.  Time for the mouth.  This time, let's give him an
    open mouth.  Before we begin, just think about how you would do that;
    that's right: it's pen and paper time :)

    First, draw the bits of Mr. Smiley Face we have so far: his head and his
    eyes.

    Now, place your pen where the top-right tip of his mouth would go.  The
    first thing we did before was to describe a semicircle going around
    clockwise; so draw that in, but don't lift your pen!

    What we'd like to do NOW is to draw a line from where we are back to where
    we started.  So do that.  You've just drawn an open mouth, and luckily the
    process for doing this in cairo is almost exactly the same.
*/
    cr.arc(0.5, 0.5, 0.35, 0, PI);
    cr.lineTo(0.5 + 0.35, 0.5);
    cr.closePath();
    cr.setSourceRGB(0.4, 0, 0);
    cr.fillPreserve();
    cr.setSourceRGB(0, 0, 0);
    cr.stroke();
/*
    It's just like I described to you: first we draw the arc that makes up the
    lower part of his mouth, and then we draw a line back to where we started.
    The next line closes the path; if we didn't do this, the mouth wouldn't
    be stroked properly.  It's hard to descibe, so if you want to see what
    happens, leave off the call to closePath, run the program, and look at the
    top right corner of his mouth.
    
    After that, all we had to do then was to fill in his mouth with a nice
    dark red, and stroke the shape with a black pen.
    
    And that's the rest of his face.  At this point, we could stop and write
    the image out, but that would look a little weird, so before we go, let's
    give him some pupils.
*/
    cr.setSourceRGB(0, 0, 0);
    cr.arc(0.5 - 0.23, 0.5 - 0.23, 0.03, 0, 2*PI);
    cr.fill();
    
    cr.arc(0.5 + 0.23, 0.5 - 0.23, 0.03, 0, 2*PI);
    cr.fill();
/*
    All done; let's write him out!
*/
    PNGSurface.writeToPNG(surface, "lesson03.png");
/*
    And we're done!  Run the program and take a look at the output.  Now
    that's looking a little better; before he was so transparent he looked
    like a ghost.

        *ba-dum ching*
        
    Yeah, it's a lame joke; but them's the breaks.  Now that you know how to
    go colour stuff in, why not modify this program to produce a blue Mr.
    Smiley Face, or even a purple one!

    Bonus marks if you can work out how to draw a PacMan look-alike :)

    See you next time.

        -- Daniel Keep
*/
}

