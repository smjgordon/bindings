These are the D bindings for libquicktime. http://libquicktime.sourceforge.net/
It is a fast and simple, low level video decoding library that can decode many formats for Linux. It is licenced under the GPL. (You might also want to check it's "companion" libs in the Gmerlin site http://gmerlin.sourceforge.net/ especially gavl might be useful for some things. For video output you could use OpenGL and for audio output you could use portaudio which also has bindings for D.)

There's an example program using Tango, dsss, gtkD and gtkDgl for making an OpenGL window. You could try to modify it for using it with derelict. (It should be pretty simple. All the things you have to change are in main.d).

The following formats are used in libquicktime and I've made the aliases available in D too. The first is the new available D alias, the second is the D type which is corresponds to, and the comment is the C type that I'm quessing is the one used by the C code.

alias int64_t long; //long long
alias uint8_t ubyte; //unsigned char
alias int16_t short; //short
alias uint16_t ushort; //unsigned short
alias int32_t int; //long
alias uint32_t uint; //unsigned long

I've no idea about this comment, but I'm keeping it here incase it means something. I quess I've removed that from somewhere:
//removed:
//lqt.h:
//void *lqt_bufalloc(size_t size);

