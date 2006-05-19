/*
    Rendering a D logo with Cairo
    
    Written by Daniel Keep, 2006.
    Released into the Public Domain.
    
    Logo designed by FunkyM.
    http://www.sukimashita.com/d/
*/
module dlogo;

import cairooo.all;
import cairooo.extra.all;
import cairooo.png.all;

import std.math;
import std.stdio;

version( Blue ) {}
else version( Grey ) {}
else version( Mono ) {}
else
{
    version = Red;
}

version( Red ) {}
else version( Blue ) {}
else version( Grey ) {}
else version( Mono ) {}
else
{
    pragma(msg, "Need to set a colour version!");
    static assert(0);
}

// Need this here to work around a bug in build
int __buildbug__;

int
main(char[][] args)
{
    try
    {
        Cairo.load();
        CairoPNG.load();
    }
    catch( CairoLoaderException e )
    {
        writefln("Sorry; couldn't load the cairo library!");
        return 1;
    }

    // Some constants
    const double IMAGE_WIDTH = 4.0;
    const double IMAGE_HEIGHT = 3.0;
    const double IMAGE_ASPECT = IMAGE_HEIGHT / IMAGE_WIDTH;
    const int IMAGE_WIDTH_PIXELS = 512;
    //const int IMAGE_HEIGHT_PIXELS = IMAGE_WIDTH_PIXELS;
    const int IMAGE_HEIGHT_PIXELS = 
        cast(int) (IMAGE_WIDTH_PIXELS * IMAGE_ASPECT);
    const double PX = IMAGE_WIDTH / IMAGE_WIDTH_PIXELS;

    // Create drawing stuff
    auto ImageSurface surface = new ImageSurface(Format.ARGB32,
            IMAGE_WIDTH_PIXELS, IMAGE_HEIGHT_PIXELS);
    auto Context cr = new Context(surface);
    auto ShapeTemplate gt = new ShapeTemplate(cr);

    // Clear the surface
    cr.setSourceRGBA(1, 1, 1, 0);
    cr.operator = Operator.Clear;
    cr.paint();

    // Now scale and center it for drawing
    //cr.translate(0, IMAGE_HEIGHT_PIXELS*(((IMAGE_WIDTH-IMAGE_HEIGHT)/2)/IMAGE_WIDTH));
    cr.scale(IMAGE_WIDTH_PIXELS/IMAGE_WIDTH,
             (IMAGE_WIDTH_PIXELS*IMAGE_ASPECT)/IMAGE_HEIGHT);

    // Colour patterns
    auto Pattern baseStroke = SolidPattern.createRGB(0,0,0);
    auto Gradient baseFill = LinearGradient.create(0,0,4,3);
    version(Blue)
        auto Pattern outerFill = SolidPattern.createRGB(0.07, 0.07, 0.65);
    else version(Grey)
        auto Pattern outerFill = SolidPattern.createRGB(0.30, 0.30, 0.30);
    else version(Mono)
        auto Pattern outerFill = SolidPattern.createRGB(0.00, 0.00, 0.00);
    else
        auto Pattern outerFill = SolidPattern.createRGB(0.65, 0.07, 0.07);
    auto Gradient hiliteFill = LinearGradient.create(0,0,4,3);
    auto Gradient shadowFill = LinearGradient.create(0,0,4,3);
    auto Pattern logoFill = SolidPattern.createRGB(1,1,1);
    auto Pattern dropShadowFill = SolidPattern.createRGBA(0.2,0.2,0.2,0.3);

    baseFill.addColorStopRGB(0,1,1,1);
    version(Blue)
        baseFill.addColorStopRGB(1,0.37,0.37,0.75);
    else version(Grey)
        baseFill.addColorStopRGB(1,0.40,0.40,0.40);
    else version(Mono)
        baseFill.addColorStopRGB(1,1.00,1.00,1.00);
    else
        baseFill.addColorStopRGB(1,0.75,0.37,0.37);
    
    version(Mono)
    {
        hiliteFill.addColorStopRGBA(0.00,0,0,0,0.00);
        shadowFill.addColorStopRGBA(0.00,0,0,0,0.00);
    }
    else
    {
        hiliteFill.addColorStopRGBA(0.00,1,1,1,0.10);
        hiliteFill.addColorStopRGBA(0.10,1,1,1,0.30);
        hiliteFill.addColorStopRGBA(0.25,1,1,1,0.70);
        hiliteFill.addColorStopRGBA(0.40,1,1,1,0.30);
        hiliteFill.addColorStopRGBA(0.50,1,1,1,0.10);
        hiliteFill.addColorStopRGBA(0.60,1,1,1,0.30);
        hiliteFill.addColorStopRGBA(0.75,1,1,1,0.70);
        hiliteFill.addColorStopRGBA(0.90,1,1,1,0.30);
        hiliteFill.addColorStopRGBA(1.00,1,1,1,0.10);

        shadowFill.addColorStopRGBA(0.00,1,1,1,0.10);
        shadowFill.addColorStopRGBA(0.10,1,1,1,0.10);
        shadowFill.addColorStopRGBA(0.25,1,1,1,0.30);
        shadowFill.addColorStopRGBA(0.43,1,1,1,0.10);
        shadowFill.addColorStopRGBA(0.54,1,1,1,0.10);
        shadowFill.addColorStopRGBA(0.67,1,1,1,0.30);
        shadowFill.addColorStopRGBA(0.81,1,1,1,0.10);
        shadowFill.addColorStopRGBA(1.00,1,1,1,0.10);
    }

    // Shape metrics
    const ROUNDED_RADIUS = 0.4;
    const LINE_WIDTH = 0.07 > 1.5*PX ? 0.07 : 1.5*PX;

    static Rect BASE_RECT = {origin:{0.1,0.1}, size:{3.8,2.8}};
    static double BASE_RADIUS = 0.4;
    static Rect OUTER_RECT = {origin:{0.2,0.2}, size:{3.6,2.6}};
    static double OUTER_RADIUS = 0.3;
    static Rect INNER_RECT = {origin:{0.3,0.3}, size:{3.4,2.4}};
    static double INNER_RADIUS = 0.2;

    static Point HILITE_PT0 = {0.0,1.5};
    static Point HILITE_PT1 = {1.5,1.5};
    static Point HILITE_PT2 = {3.0,1.2};
    static Point HILITE_PT3 = {4.0,0.9};

    static double SHADOW_SCALE = 0.99;
    static Point SHADOW_OFFSET = {0.1,0.1};
    
    // Reset context
    cr.lineWidth = LINE_WIDTH;
    cr.setSourceRGB(0, 0, 0);
    cr.operator = Operator.Over;

    // Scale context to draw shadow
    version(Mono) {}
    else
    {
        cr.save();
        cr.scale(SHADOW_SCALE, SHADOW_SCALE);
        cr.translate(SHADOW_OFFSET.x, SHADOW_OFFSET.y);

        // Draw shadow
        gt.roundedRectangle(BASE_RECT, BASE_RADIUS);
        cr.setSource(dropShadowFill);
        cr.fill();
        
        // Restore context
        cr.restore();
    }

    // Scale context to draw logo itself
    cr.save();
    version(Mono) {}
    else
        cr.scale(SHADOW_SCALE, SHADOW_SCALE);
    
    // Draw base
    gt.roundedRectangle(BASE_RECT, BASE_RADIUS);
    cr.setSource(baseFill);
    cr.fillPreserve();
    cr.setSource(baseStroke);
    cr.stroke();

    // Draw outer fill
    gt.roundedRectangle(OUTER_RECT, OUTER_RADIUS);
    cr.setSource(outerFill);
    cr.fill();

    // Draw inner hilite fill
    cr.save();
    {
        // Clip
        cr.moveTo(0, 0);
        cr.lineTo(HILITE_PT0.x, HILITE_PT0.y);
        cr.curveTo(HILITE_PT1.x, HILITE_PT1.y,
                   HILITE_PT2.x, HILITE_PT2.y,
                   HILITE_PT3.x, HILITE_PT3.y);
        cr.lineTo(4, 0);
        cr.closePath();
        cr.clip();

        // Draw hilite fill
        gt.roundedRectangle(INNER_RECT, INNER_RADIUS);
        cr.setSource(hiliteFill);
        cr.fill();
    }
    cr.restore();

    // Draw inner shadow fill
    cr.save();
    {
        // Clip
        cr.moveTo(0, 3);
        cr.lineTo(HILITE_PT0.x, HILITE_PT0.y);
        cr.curveTo(HILITE_PT1.x, HILITE_PT1.y,
                   HILITE_PT2.x, HILITE_PT2.y,
                   HILITE_PT3.x, HILITE_PT3.y);
        cr.lineTo(4, 3);
        cr.closePath();
        cr.clip();
        
        // Draw shadow fill
        gt.roundedRectangle(INNER_RECT, INNER_RADIUS);
        cr.setSource(shadowFill);
        cr.fill();
    }
    cr.restore();

    // Draw the logo itself
    cr.moveTo   (0.50, 0.50);
    cr.lineTo   (1.60, 0.50);
    cr.curveTo  (3.10, 0.50,
                 3.10, 2.50,
                 1.60, 2.50);
    cr.lineTo   (0.50, 2.50);
    cr.lineTo   (0.95, 2.10); // (0.95, 2.05);
    cr.lineTo   (1.40, 2.10); // (1.40, 2.05);
    cr.curveTo  (2.60, 2.10,  // (2.60, 2.05,
                 2.60, 0.85,  //  2.60, 0.90,
                 1.40, 0.85); //  1.40, 0.90);
    cr.lineTo   (0.95, 0.85); // (0.95, 0.90);
    cr.lineTo   (0.95, 2.10); // (0.95, 2.05);
    cr.lineTo   (0.50, 2.50);
    cr.closePath();
    
    cr.moveTo   (2.60, 2.50);
    cr.lineTo   (3.30, 2.50);
    cr.curveTo  (4.10, 1.40,
                 2.90, 0.60,
                 2.10, 0.30);
    cr.curveTo  (2.90, 0.80,
                 3.70, 1.45,
                 2.60, 2.50);
    cr.closePath();
    cr.setSource(logoFill);
    cr.fill();

    // Restore context
    cr.restore();

    // Save image to disk
    char[] outputPath;
    version(Red)
        outputPath = "dlogo-red.png";
    version(Blue)
        outputPath = "dlogo-blue.png";
    version(Grey)
        outputPath = "dlogo-grey.png";
    version(Mono)
        outputPath = "dlogo-mono.png";
    
    writefln("Writing output to %s", outputPath);
    PNGSurface.writeToPNG(surface, outputPath);

    return 0;
}

