D bindings to Jack audio system.
These are the quick and dirty D bindings to Jack.
More info about Jack: http://jackaudio.org/

Created on 18th December 2010.

It's a cross platform (Linux, Mac OS X, Windows, +others) audio server which is targeted at professional audio uses. It aims at the lowest latency possible, and has a "unique" system where you can hook up multiple Jack applications to each other through the main Jack server. But you can just use it to play simple audio too. For games OpenAL would propably be a better fit.

I'm still not sure how the D garbage collector fits Jack's callbacks, and will it cause some latency issues and drop-outs. We'll see after it's tested in some real D application.

I have only tested the basic functionality shown in the metro example. I don't even know if all the jack d modules will compile or not. They should, but might not.

BINDINGS LICENCE
The same as the Jack API: LGPL, or whatever the Jack API will be in the future.

INSTALLING
I've only tested this on Mac OS X. For OS X I installed the http://www.jackosx.com/ version 0.87 for 32 bit machines. It should contain and install everything needed.

I used D1, GDC, tango 0.99.8 and DSSS. If you get a working setup you should just run:
dsss build && ./metro
to hear some low beeps.

