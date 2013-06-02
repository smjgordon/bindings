// D Bindings for DirectX
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.d3dcompiler;


import win32.directx.dxinternal;
public import win32.directx.dxpublic;
import win32.directx.dxgi;
import win32.directx.d3d11shader;
import win32.windows;
import std.c.windows.com;


alias std.c.windows.com.IUnknown IUnknown;
alias std.c.windows.com.GUID GUID;
alias std.c.windows.com.IID IID;


version(DXSDK_11_0)
{
    //pragma(lib, "d3dcompiler_43.lib");
    pragma(lib, "d3dcompiler.lib");	// links d3dcompiler_43.dll
}
else version(DXSDK_11_1)
{
    //pragma(lib, "d3dcompiler_46.lib");
    pragma(lib, "d3dcompiler.lib");	// links d3dcompiler_46.dll
}
else
{
    static assert(false, "DirectX SDK version either unsupported or undefined");
}


/////////////////////////
// D3DCompiler Enums


enum D3DCOMPILE : uint 
{
    DEBUG                          = (1 << 0),
    SKIP_VALIDATION                = (1 << 1),
    SKIP_OPTIMIZATION              = (1 << 2),
    PACK_MATRIX_ROW_MAJOR          = (1 << 3),
    PACK_MATRIX_COLUMN_MAJOR       = (1 << 4),
    PARTIAL_PRECISION              = (1 << 5),
    FORCE_VS_SOFTWARE_NO_OPT       = (1 << 6),
    FORCE_PS_SOFTWARE_NO_OPT       = (1 << 7),
    NO_PRESHADER                   = (1 << 8),
    AVOID_FLOW_CONTROL             = (1 << 9),
    PREFER_FLOW_CONTROL            = (1 << 10),
    ENABLE_STRICTNESS              = (1 << 11),
    ENABLE_BACKWARDS_COMPATIBILITY = (1 << 12),
    IEEE_STRICTNESS                = (1 << 13),
    OPTIMIZATION_LEVEL0            = (1 << 14),
    OPTIMIZATION_LEVEL1            = 0,
    OPTIMIZATION_LEVEL2            = ((1 << 14) | (1 << 15)),
    OPTIMIZATION_LEVEL3            = (1 << 15),
    RESERVED16                     = (1 << 16),
    RESERVED17                     = (1 << 17),
    WARNINGS_ARE_ERRORS            = (1 << 18),
}


enum D3DCOMPILE_EFFECT : uint
{
    CHILD_EFFECT = 1,
    ALLOW_SLOW_OPS = 2,
}


enum D3D_DISASM : uint
{
    ENABLE_COLOR_CODE            = 0x00000001,
    ENABLE_DEFAULT_VALUE_PRINTS  = 0x00000002,
    ENABLE_INSTRUCTION_NUMBERING = 0x00000004,
    ENABLE_INSTRUCTION_CYCLE     = 0x00000008,
    DISABLE_DEBUG_INFO           = 0x00000010,
}


enum D3DCOMPILER_STRIP : uint
{
    REFLECTION_DATA = 1,
    DEBUG_INFO = 2,
    TEST_BLOBS = 4,
}

enum D3D_BLOB_PART : uint
{
    D3D_BLOB_INPUT_SIGNATURE_BLOB,
    D3D_BLOB_OUTPUT_SIGNATURE_BLOB,
    D3D_BLOB_INPUT_AND_OUTPUT_SIGNATURE_BLOB,
    D3D_BLOB_PATCH_CONSTANT_SIGNATURE_BLOB,
    D3D_BLOB_ALL_SIGNATURE_BLOB,
    D3D_BLOB_DEBUG_INFO,
    D3D_BLOB_LEGACY_SHADER,
    D3D_BLOB_XNA_PREPASS_SHADER,
    D3D_BLOB_XNA_SHADER,

    // Test parts are only produced by special compiler versions and so
    // are usually not present in shaders.
    D3D_BLOB_TEST_ALTERNATE_SHADER = 0x8000,
    D3D_BLOB_TEST_COMPILE_DETAILS,
    D3D_BLOB_TEST_COMPILE_PERF,
}


enum D3D_COMPRESS_SHADER_KEEP_ALL_PARTS = 0x00000001;


/////////////////////////
// D3DCompiler Structs


struct D3D_SHADER_DATA
{
    const void* pBytecode;
    size_t BytecodeLength;
}


/////////////////////////
// D3DCompiler Interfaces


extern(Windows)
{
HRESULT D3DCompile(
    in void* pSrcData,
    size_t SrcDataSize,
    in char* pSourceName,
    in D3D_SHADER_MACRO* pDefines,
    /*optional*/ ID3DInclude pInclude,
    in char* pEntrypoint,
    in char* pTarget,
    uint Flags1,
    uint Flags2,
    out ID3DBlob ppCode,
    /*optional*/ ID3DBlob* ppErrorMsgs = null
    );

HRESULT D3DPreprocess(
    in void* pSrcData,
    size_t SrcDataSize,
    in char* pSourceName,
    in D3D_SHADER_MACRO* pDefines,
    /*optional*/ ID3DInclude pInclude,
    out ID3DBlob ppCodeText,
    /*optional*/ ID3DBlob* ppErrorMsgs = null
    );

HRESULT D3DGetDebugInfo(
    in void* pSrcData,
    size_t SrcDataSize,
    out ID3DBlob ppDebugInfo
    );

HRESULT D3DReflect(
    in void* pSrcData,
    size_t SrcDataSize,
    IID* pInterface,
    void** ppReflector);

HRESULT D3DDisassemble(
    in void* pSrcData,
    size_t SrcDataSize,
    uint Flags,
    in char* szComments,
    out ID3DBlob ppDisassembly
    );

/*
TODOZ: If implementing d3d10effect.h, move this into that file
HRESULT D3DDisassemble10Effect(
    ID3D10Effect pEffect, 
    uint Flags,
    out ID3DBlob ppDisassembly
    );
*/

HRESULT D3DGetInputSignatureBlob(
    in void* pSrcData,
    size_t SrcDataSize,
    out ID3DBlob ppSignatureBlob
    );

HRESULT D3DGetOutputSignatureBlob(
    in void* pSrcData,
    size_t SrcDataSize,
    out ID3DBlob ppSignatureBlob
    );

HRESULT D3DGetInputAndOutputSignatureBlob(
    in void* pSrcData,
    size_t SrcDataSize,
    out ID3DBlob ppSignatureBlob
    );

HRESULT D3DStripShader(
    in void* pShaderBytecode,
    size_t BytecodeLength,
    uint uStripFlags,
    out ID3DBlob ppStrippedBlob
    );

HRESULT D3DGetBlobPart(
    in void* pSrcData,
    size_t SrcDataSize,
    D3D_BLOB_PART Part,
    uint Flags,
    out ID3DBlob ppPart
    );

HRESULT D3DCompressShaders(
    uint uNumShaders,
    D3D_SHADER_DATA* pShaderData,
    uint uFlags,
    ID3DBlob* ppCompressedData
    );

HRESULT D3DDecompressShaders(
    in void* pSrcData,
    size_t SrcDataSize,
    uint uNumShaders,       
    uint uStartIndex,
    uint* pIndices,
    uint uFlags,
    ID3DBlob* ppShadersCArray,
    uint* pTotalShaders
    );

HRESULT D3DCreateBlob(
    size_t Size,
    out ID3DBlob ppBlob
    );
}


HRESULT D3DReflect(in ubyte[] shaderData, out ID3D11ShaderReflection reflector)
{
	return D3DReflect(shaderData.ptr, shaderData.length, &IID_ID3D11ShaderReflection, cast(void**)&reflector);
}


HRESULT D3DReflect(in ubyte[] shaderData, ID3D11ShaderReflection* reflector)
{
	return D3DReflect(shaderData.ptr, shaderData.length, &IID_ID3D11ShaderReflection, cast(void**)reflector);
}
