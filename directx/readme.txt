D Bindings for DirectX
  by Sean Cavanaugh - WorksOnMyMachine@gmail.com
    (Aug 11 2012)

        
===============================================================================

Changes - Aug 11 2010

Fixed D3DReflect API, the following non COM interfaces are now callable
from D:

    ID3D11ShaderReflectionType
    ID3D11ShaderReflectionVariable
    ID3D11ShaderReflectionConstantBuffer

===============================================================================

=====
Notes
=====

    The API is rather large, and I only use a portion of it.  This means
some of function bindings might not work due not having actually run them
to prove they work.  This also goes for the structs, but in the case of structs
there is also a compile time static assert that checks their size with respect
to sizes pulled from a test applet which was compiled against MSVC++ 2010, for
32 and 64 bit.   The simple case of creating a vertex and pixel shader, vertex
buffer, index buffer, and drawing some triangles 'Works on My Machine'.

    This project depends on the 'WindowsApi' win32 bindings project at
    (svn) http://www.dsource.org/projects/bindings/trunk/win32
    (website) http://www.dsource.org/projects/bindings
    
    All around you need this win32 module to do serious work on Windows.


===============
What's Included
===============

(o) DXGI : This layer is what D3D10 and D3D11 build upon and manages the
    'boilerplate' behaviors and glue for HWNDs and front buffers needed in D3D
    applications.
(o) D3D11 : The D3D11 interfaces.
(o) D3DCompiler : The interfaces for shader compilation and reflection.
    Shaders are code, so I highly recommending treating them as such and 
    compiling shaders fully offline except for prototyping or runtime debugging
    purposes.
(o) XAudio2 - Basic audio playback
(o) X3DAudio - Some API's that build upon XAudio2 to provide positional
    audio
(o) XInput - Needed for accessing gamepads, and anything else that isn't a
    mouse or keyboard.  Code for Mouse and Keyboard events should use the
    traditional windows message queue or possibly the raw input forms of the
    windows messages.
(o) D2D and DWrite : Preliminary port.  I've audited the code by hand a few
    times but also have not written any code using it to prove it.

What's Missing (but I will get to eventually (maybe)):
(o) XACT3
(o) XAPO
(o) XDSP

==============
What's Missing
==============

(o) Import Libraries: You will need to extract D compatible version of the
import libraries yourself for the time being.   coffimplib will do the trick
when run against the MSVC C++ import libraries in the SDK.

(o) DXErr : This is a static C/C++ library and not a DLL import library so
cannot be trivially ported to D.  While a nice lookup for HRESULT to human
readable codes is useful some of the time, the reality of D3D programming
makes the vast majority of graphics problems require PIX debugging to debug
errors in the render state which are not generating HRESULT errors in the first
place.  This is even more true in D3D11 as a large number of the APIs no longer
return HRESULTs as most of the error checking only happens when creating
resources and state objects.

(o) Samples : Porting C++ D3D samples to D is not my idea of an exciting
project when I can write brand new programs I care about, and use those as
samples instead.

(o) DInput : Superceeded by XInput.

(o) DSound : Superceeded by XAudio2.

(o) DDraw : Extremely obbsolete.

(o) D3D10 : Use D3D11, its more flexible and can target 9 through 11 hardware.

(o) D3D9 : I like this API but new programs should just move to 11.

(o) D3D11Effect & D3D10Effect : The effects system always started out as an

example and as a tool for prototyping.  The performance was improved a bit
over time, and Microsoft migrated the library into a sample when upgrading
the code for D3D11.  Porting the sample is doable, but would be more work
than just getting the core DirectX SDK bindings made for D, which are primarily
made up of #defines, structs, and COM interfaces which are rather
straightforward to port.

(o) XNAMath - Too much extra work due to the quantity of unused functions
provided by the library for most projects.  I greatly prefer to only implement
math functions I will use, to ensure they work properly.

=======
Changes
=======

    Compiling against this SDK requires explicitly setting a D version as a
project setting or command line version.  If you forget there will be a helpful
error message to point out this requirement. 
    DXSDK_JUNE_2010
    
    As there is no __uuidof in D, all of the GUID's are exposed as global
module variables of type IID, matching the name of the interface, prefixed
with IID_.  So the IID for ID3D11Texture is called IID_ID3D11Texture.

    For the most part documented enums, structs, and COM and C functions
exposed by the supported parts of D port of DirectX are available as-is.
However, since it is a port, some minor liberties were taken during the
effort.

    Changing most of the C++ #defines to enums is fairly straightforward.
However some of the free defines have been given enum types to give them
stricter type safety which D can provide over C++.  For the most part enums
have an owning type, which matches the prefix for the enumeration.

(o) For example in C++:
    DXGI_FORMAT_R8G8B8A8_UNORM_SRGB
(o) Becomes this in D:
    DXGI_FORMAT.R8G8B8A8_UNORM_SRGB


(o) Where the suffix in C++ starts with a numerical digit, there is a leading
added, so that the following C++ code:
    D3D11_PRIMITIVE_TOPOLOGY_4_CONTROL_POINT_PATCHLIST
(o) Becomes this in D:
    D3D11_PRIMITIVE_TOPOLOGY._4_CONTROL_POINT_PATCHLIST



    The final complication is not all of the enum names match the prefix of the
variables.  In this case there is an alias of the full name to the prefix name.
This allows variable types to match C+++ code, but the change to the usage of
the enum to only need the change of an underscore into a period.

(o) For example the C++ type D3D_CBUFFER_TYPE has D3D_CT_CBUFFER.
(o) The equivalent D type is the same, D3D_CBUFFER_TYPE, but it is also an
alias to D3D_CT, so that you can type D3D_CT.CBUFFER for referencing the value.



    Some of Microsoft's enumerations did not have types assigned to them, this
has been improved as well.  This is to allow stricter type safety in your code,
instead of having the code use a generic int or uint.

(o) DXGI_STATUS - Contains #defines for DXGI_STATUS_*
(o) DXGI_ERROR - Contains #defines for DXGI_ERROR_*
(o) DXGI_CPU_ACCESS - Contains #defines for DXGI_CPU_ACCESS_*
(o) DXGI_USAGE - Contains #defines for DXGI_USAGE_*
(o) DXGI_MAP - Contains #defines for DXGI_MAP_*
(o) DXGI_RESOURCE_PRIORITY - Contains #defines for DXGI_RESOURCE_PRIORITY_*
(o) DXGI_ENUM_MODES - Contains #defines for DXGI_ENUM_MODES_*
(o) DXGI_PRESENT - Contains #defines for DXGI_PRESENT_*
(o) DXGI_MWA - Contains #defines for DXGI_MWA_*
(o) D3DCOMPILE_FLAGS - Contains #defines for D3DCOMPILE_*
(o) D3DCOMPILE_EFFECT - Contains #defines for D3DCOMPILE_EFFECT_*
(o) D3D_DISASM - Contains #defines for D3D_DISASM_*


Ommissions
    d3dcompiler.d does not implement D3DDisassemble10Effect, due to
dependencies in the API on types defined in a dll that is not going to be
ported (D3D10Effect).


Modifications
    Nearly all data types were converted to native D data types.  The only
real survivors are BOOL and HRESULT.

