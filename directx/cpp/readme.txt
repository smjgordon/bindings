This project is designed to replace the D3DReflect API from the June 2010 
DirectX SDK.

The reflect API uses 4 interfaces, only of which 1 is a true COM interface.

D only supports calling C and COM functions, so a workaround is needed for
Microsofts design mistake.

This wrapper fixes the other three interfaces to derive from IUnknown, however
this required replacing the real GUIDs with wrapper GUIDs.  Using the fixed
API requires using the new GUIDs, and linking against d3dreflect.dll

The front end method is normally D3DReflect, and the wrapped version is
D3DReflectCOM.  An up to date copy of the d3d bindings for D should is
configured to use this wrapper and code should just use the helper function
D3DReflect.

!!!
Note that any code porting from C or C++ into D that uses the D3DReflect API
must take care to call .Release() on the following interfaces, that were not
previously derived from IUnknown:

ID3D11ShaderReflectionType
ID3D11ShaderReflectionVariable
ID3D11ShaderReflectionConstantBuffer
!!!


The batch file is very crude if you build it yourself, it will need some changes:
  (o) The include path to the June 2010 DirectX SDK headers needs to be passed 
      in correctly
  (o) It expects Visual Studio 2010 to be in the path (i.e. vcvars32 has been
      run for VS2010)
  (o) coffimplib from ftp.digitalmars.com is in your path so it can convert the
      coff format import library for the dll into an optlink format import 
      library.  The D version of the library lands in the x86 directory, the
      Debug and Release directories contain the C++ intermediates, libs, and 
      other output.
      
      