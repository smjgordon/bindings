Original Author: Clay Smith (clayasaurus@gmail.com)

Windows porter: mystery_guy_from_the_future_who_is_the_best_hacker_ever_and_i_owe_a_million_dollars_to_;)

If anyone gets this code working for windows, PLEASE email me and update this repo. Thx.

Basic Raknet bindings for linux. Allows use of bitstreams and RPC, comes with a chat sample and a networked opengl 
line drawing sample using my 2D game framework for warbots & derelict, based upon irrlicht's Raknet example.

I started this 'binding' in order to get the C++ version of raknet to work with D. I got it to work with D on 
linux, however, to my dismay, I learned that it is /impossible/ to get it to work for the windows version. Here's 
the list of things I have tried, and solutions that might be available for the future.

What doesn't work...
1) Building Raknet with DMC (not supported) 
2) using coff2omf to convert microsoft lib to D's lib format... doesn't work.
3) using cygwin with gdc, too many issues, plus slow as molasses, and not windows native.


Future solutions...
1) If anyone can figure out how to load the raknet DLL/shared lib at runtime
2) If an alternate D compiler is available for windows that has a linker that can link either Microsofts .lib files 
or GCC's .a files
3) Raknet decides to support DMC compiler

Anyways, the bindings are very straight forward and as close to the Raknet metal as possible. I'm not going to use 
them until I or someone else figures out how to get it to work for windows. 

Have a nice day,
~ Clay
