/*
    cairooo tutorial, lesson 1
    The basics.
    
    Written by Daniel Keep, 2006.
    Released into the Public Domain.
    
    Welcome to the first cairooo tutorial!  In this lesson, I'm going to show
    you how to get started using the object-oriented binding for cairo,
    cairooo.
    
    First of all, I'm going to assume that you've downloaded the cairooo
    bindings.  If you haven't see the instructions that come with the tutorial
    files.
    
    So, let's start with the basic stuff and get the imports out of the way:
*/
import cairooo.all;
import cairooo.png.all;

import std.math;
import std.stdio;
/*
    In the first line, we're importing the basic cairooo library in whole so
    that we don't have to worry about which classes are in which files.  Unless
    you have some specific reason to do otherwise, this is generally the way to
    go.
    
    That second line imports the PNG functions of cairooo.  We'll be using
    these later on to write our image out to disk.

    After that, we're just importing some regular D libraries.

    Next, we're going to load these two packages.  Cairooo binds to the cairo
    library dynamically at runtime, which means we have to tell it when we
    want to load the library proper.

    For the sake of simplicity, we'll be doing this in a static constructor.
*/
static this()
{
    Cairo.load();
    CairoPNG.load();
}
/*
    It's important to note that these calls can fail.  This usually happens
    because either the cairo library itself is missing, or because it doesn't
    support the features you're asking for.

    If cairooo isn't able to load a package, it will throw an exception that
    you can then catch, and process.  You can use this to tell the user their
    cairo library doesn't support that functionality, or to switch to a
    different code path.

    In this case, we aren't really worried about that; it's only a tutorial.
    But in a serious program, you will want to handle these situations.
    
    Aside: Why the separation?

    You might wonder why we have to import two different packages when both
    are a part of cairo.  The reason is that while cairo implements a lot of
    different functions, not all of them are always compiled into the library!
    For example, Windows users are unlikely to have a cairo library with the
    X11 backend built in; conversely, UNIX users aren't likely to have the
    Windows functions in their cairo library.  As a result, if we just
    imported everything cairo supported, we'd never be able to load the
    library!

    So remember to only ever load the packages you will be using.  Or, at the
    very least, make sure to deal with the case where a package might fail to
    load.
*/
void main()
{
/*
    Now we're going to create a surface and a context.  The surface is the
    thing that cairo will actually draw onto, whilst the context is what we
    use to communicate our drawing instructions to cairo.
*/
    auto ImageSurface surface =
        new ImageSurface(Format.ARGB32, 256, 256);
    auto Context cr = new Context(surface);
/*
    Nothing too difficult: we created an in-memory image surface that is 256
    pixels wide by 256 pixels high, using ARGB colour (RGB colour with an
    alpha channel).  We then created a context that will let us perform
    drawing operations on that surface.

    You may, however, be wondering about that 'auto' thing.  In D, 'auto'
    serves three purposes:

    1. When used without a type following it, it asks D to work out the type
       of a variable itself, saving you from having to specify it,
    2. It is used to mark a class as being 'auto', and
    3. It is used to create auto references.

    An auto reference is like a normal object reference, except that it will
    be automatically destroyed when you leave the current scope.  This is
    *very* handy for us, since graphics objects can be expensive memory-wise,
    and so we want to destroy them as soon as we are finished with them.

    Although you aren't forced to, it's a good idea to make all of your cairo
    objects 'auto' so that you don't accidentally forget to destroy them.

    Now that we've got our context, let's start setting it up.

    Aside: What about the Garbage Collector?

    Some of you may be thinking, "Ha!  D has a garbage collector: I can just
    let THAT take care of my objects!"... and you'd be right.  But in the case
    of cairo, that's a *really* bad idea.

    Here's an example of why: on some systems, the number of drawing contexts
    you can have is finite.  Now let's suppose you've written an application
    using cairo that creates lots and lots of contexts, and then leaves them
    to be freed by the GC.

    What will happen is that you program will quickly consume all the
    available drawing contexts on the system, bringing the system to a halt.
    But shouldn't the GC have freed those resources?  Aah, but the GC doesn't
    run unless you actually *run out of memory*.  But since you've run out of
    device contexts and not memory, it doesn't run.

    In fact, it's generally a bad idea to leave very large objects, or objects
    which hold on to system resources for the GC to clean up; it's much better
    practice to manage the lifetime of these objects yourself.  Auto classes
    and references make it easier to do this.

    And now back to your regularily scheduled program...
*/
    cr.rectangle(0, 0, 256, 256);
    cr.setSourceRGBA(1, 1, 1, 0);
    cr.operator = Operator.Clear;
    cr.fill();
/*
    These four lines "clear" the surface we just created.  Breaking it down,
    what they did was:

    1. Describe a rectangle that occupies the entire surface.
    2. Tell cairo that we're going to be using the color white, with full
       transparency.
    3. Tell cairo that when we draw, we don't want to do any kind of blending:
       just replace anything that's already there with the colour we
       specified (if we didn't do this; we'd be drawing a transparent
       rectangle, and thus it wouldn't actually *do* anything...)
    4. Fill the rectangle we described with the colour we gave cairo.

    The exact mechanics of these lines will be explained later; for the
    moment, just smile, nod, and accept that these clear the surface.  Trust
    me...
*/
    cr.lineWidth = 5;
/*
    This line will set the width of lines that we draw; in this case, we'll be
    drawing 5 pixel-wide lines.  From now on, all lines that we draw will have
    this width (until we change it to something else).
*/
    cr.setSourceRGB(0, 0, 0);
/*
    This tells cairo that when we draw stuff, we want to use the colour black.
    This will apply to both filling stuff in, and drawing lines around stuff.
*/
    cr.operator = Operator.Over;
/*
    This line tells cairo that when it draws stuff for us, we want it to draw
    them over the top of whatever is already there.  This is the "usual" way
    of drawing things, and will perform alpha blending in the expected
    fashion.  When in doubt, use this operator.
*/
    cr.arc(128, 128, 120, 0, 2*PI);
/*
    Now we're getting down to the good stuff.  This line is telling our
    context that we want to draw an arc (ie: part of a circle).  The first two
    arguments are the center of this circle (in this case; it's the middle of
    our surface).  The next argument tells the context the radius of the arc,
    and the last two specify the start and end angles.

    If you know your math, then you'll see that we've actually described a
    full, closed circle.  If so, skip to the next line of code.  If not, read
    on.

    First up, grab a piece of paper and a pen (or a pencil, crayon, or
    whatever you use to draw stuff).  Now, draw a dot in the middle of the
    paper.  That's what our first two arguments tell cairo: the position of
    that dot on the page in X and Y coordinates.

    Next, draw a dotted line of some length horizontally out to the right from
    the dot.  The length of that line is the third argument: the radius.

    Now, imagine that line as being our "zero angle".  With your pen starting
    on the end of that line, draw a circle *clockwise* around the dot
    (keeping at the same distance from it as you go around), all the way back
    to where you started.  That's what the last two arguments describe: the
    angle to start drawing at, and where to end at.

    A few notes to make: cairo draws its arcs (and, in fact, does anything
    regarding angles) clockwise, and specifies its angles using radians.
    
    If you can't remember how to go between degrees and radians, here's a
    quick reminder:

        Radians = Degrees / 180 * PI
        Degrees = Radians / PI * 180

        360 Degrees = 2*PI Radians
        180 Degrees =   PI Radians
         90 Degrees = PI/2 Radians
         45 Degrees = PI/4 Radians
         30 Degrees = PI/6 Radians

    If you like to think in degrees, you may want to write yourself a pair of
    functions for converting between the two.  *All* angles in cairo use
    radians.
*/
    cr.stroke();
/*
    Now, what this does is it says to cairo: "Ok, take whatever path that I've
    just described to you, along with all the other things like line width,
    colour, etc., and draw a line around it."

    So, cairo will take the colour we gave it (black), the line width (5), and
    draw a line around the shape we described (a full circle).

    At this point, our surface will have a black circle on it!  It's also
    worth noting that the path we described will also be consumed in the
    process.  This means that if we called stroke again right away, nothing
    would happen.  We have to describe a new path to cairo first.

    However, before we do that, let's output what our surface looks like so
    far.  In fact, we're going to output our surface every time we draw
    something so that you can see what it is that we're drawing, and how cairo
    puts it together.
*/
    PNGSurface.writeToPNG(surface, "lesson01-step01.png");
/*
    That line will write our surface out to disk as a PNG image.  Handy, huh?

    Now, see if you can guess what we're drawing in the next few blocks of
    code... (you can always run the program and look at the images--but that
    would be cheating!)
*/
    cr.arc(128 - 60, 128 - 60, 16, 0, 2*PI);
    cr.stroke();
    PNGSurface.writeToPNG(surface, "lesson01-step02.png");
/*
    That's another, smaller circle in the upper-left part of our surface...
*/
    cr.arc(128 + 60, 128 - 60, 16, 0, 2*PI);
    cr.stroke();
    PNGSurface.writeToPNG(surface, "lesson01-step03.png");
/*
    And there's another...
*/
    cr.arc(128, 128, 90, 0, PI);
    cr.stroke();
    PNGSurface.writeToPNG(surface, "lesson01-step04.png");
/*
    So, have you guessed what we're drawing?

    Why, it's a smiley face!  And who said graphics programming wasn't fun?

    And, believe it or not, that's all there is to it.  If this were a
    tutorial for the C api for cairo, we'd probably have to free up the
    resources we've used at this point, but because we declared them all
    'auto', we don't need to: you can rest assured that D will take care of
    destroying our context and surface when this function ends.

    So that's it for our first lesson!  You now know how to set up a basic
    cairo surface and context, and draw some circles onto it.  See you next
    time!

        -- Daniel Keep
*/
}

