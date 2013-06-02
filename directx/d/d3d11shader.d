// D Bindings for DirectX
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.d3d11shader;


import win32.directx.dxinternal;
public import win32.directx.dxpublic;
import win32.directx.d3d11;
import win32.directx.dxgi;
import win32.windows;
import std.c.windows.com;


alias std.c.windows.com.IUnknown IUnknown;
alias std.c.windows.com.GUID GUID;
alias std.c.windows.com.IID IID;


version(DXSDK_11_0)
{
    pragma(lib, "d3dx11.lib");
}
else version(DXSDK_11_1)
{
	pragma(lib, "d3dcompiler.lib");
}
else
{
    static assert(false, "DirectX SDK version either unsupported or undefined");
}


/////////////////////////
// Sanity checks against canocial sizes from VS2010 C++ test applet

// Enums
static assert(D3D11_CBUFFER_TYPE.sizeof == 4);
static assert(D3D11_RESOURCE_RETURN_TYPE.sizeof == 4);
static assert(D3D11_SHADER_VERSION_TYPE.sizeof == 4);
static assert(D3D11_TESSELLATOR_DOMAIN.sizeof == 4);
static assert(D3D11_TESSELLATOR_PARTITIONING.sizeof == 4);
static assert(D3D11_TESSELLATOR_OUTPUT_PRIMITIVE.sizeof == 4);
static assert(D3D11_REGISTER_COMPONENT_TYPE.sizeof == 4);
static assert(D3D11_SHADER_INPUT_FLAGS.sizeof == 4);
static assert(D3D11_SHADER_INPUT_TYPE.sizeof == 4);
static assert(D3D11_SHADER_CBUFFER_FLAGS.sizeof == 4);
static assert(D3D11_NAME.sizeof == 4);
static assert(D3D11_SHADER_VARIABLE_CLASS.sizeof == 4);
static assert(D3D11_SHADER_VARIABLE_FLAGS.sizeof == 4);
static assert(D3D11_SHADER_VARIABLE_TYPE.sizeof == 4);

// Structs
version(X86)
{
static assert(D3D11_SHADER_BUFFER_DESC.sizeof == 20);
static assert(D3D11_SHADER_DESC.sizeof == 152);
static assert(D3D11_SHADER_INPUT_BIND_DESC.sizeof == 32);
static assert(D3D11_SHADER_TYPE_DESC.sizeof == 32);
static assert(D3D11_SHADER_VARIABLE_DESC.sizeof == 36);
static assert(D3D11_SIGNATURE_PARAMETER_DESC.sizeof == 28);
}
version(X86_64)
{
static assert(D3D11_SHADER_BUFFER_DESC.sizeof == 24);
static assert(D3D11_SHADER_DESC.sizeof == 160);
static assert(D3D11_SHADER_INPUT_BIND_DESC.sizeof == 40);
static assert(D3D11_SHADER_TYPE_DESC.sizeof == 40);
static assert(D3D11_SHADER_VARIABLE_DESC.sizeof == 48);
static assert(D3D11_SIGNATURE_PARAMETER_DESC.sizeof == 32);
}


/////////////////////////
// D3D11Shader Templates


template D3D11_SHVER_GET_TYPE()
{
    uint MAKE_HRESULT(uint Version)
    {
        return (((Version) >> 16) & 0xffff);
    }
}


template D3D11_SHVER_GET_MAJOR()
{
    uint D3D11_SHVER_GET_MAJOR(uint Version)
    {
        return (((Version) >> 4) & 0xf);
    }
}


template D3D11_SHVER_GET_MINOR()
{
    uint D3D11_SHVER_GET_MINOR(uint Version)
    {
        return (((Version) >> 0) & 0xf);
    }
}


/////////////////////////
// D3D11Shader Enums

// Canonical D3D11 Shader Enums

enum D3D11_CBUFFER_TYPE : uint
{
    CBUFFER = D3D_CT.CBUFFER,
    TBUFFER = D3D_CT.TBUFFER,
    INTERFACE_POINTERS = D3D_CT.INTERFACE_POINTERS,
    RESOURCE_BIND_INFO = D3D_CT.RESOURCE_BIND_INFO,
}
alias D3D11_CBUFFER_TYPE D3D11_CT;


enum D3D11_RESOURCE_RETURN_TYPE : uint
{
    UNORM = D3D_RESOURCE_RETURN_TYPE.UNORM,
    SNORM = D3D_RESOURCE_RETURN_TYPE.SNORM,
    SINT = D3D_RESOURCE_RETURN_TYPE.SINT,
    UINT = D3D_RESOURCE_RETURN_TYPE.UINT,
    FLOAT = D3D_RESOURCE_RETURN_TYPE.FLOAT,
    MIXED = D3D_RESOURCE_RETURN_TYPE.MIXED,
    DOUBLE = D3D_RESOURCE_RETURN_TYPE.DOUBLE,
    CONTINUED = D3D_RESOURCE_RETURN_TYPE.CONTINUED,
}
alias D3D11_RESOURCE_RETURN_TYPE D3D11_RETURN_TYPE;


enum D3D11_SHADER_VERSION_TYPE : uint
{
    PIXEL_SHADER = 0,
    VERTEX_SHADER = 1,
    GEOMETRY_SHADER = 2,
    HULL_SHADER = 3,
    DOMAIN_SHADER = 4,
    COMPUTE_SHADER = 5,
}
alias D3D11_SHADER_VERSION_TYPE D3D11_SHVER;


enum D3D11_TESSELLATOR_DOMAIN : uint
{
    UNDEFINED = D3D_TESSELLATOR_DOMAIN.UNDEFINED,
    ISOLINE = D3D_TESSELLATOR_DOMAIN.ISOLINE,
    TRI = D3D_TESSELLATOR_DOMAIN.TRI,
    QUAD = D3D_TESSELLATOR_DOMAIN.QUAD,
}


enum D3D11_TESSELLATOR_PARTITIONING : uint
{
    UNDEFINED = D3D_TESSELLATOR_PARTITIONING.UNDEFINED,
    INTEGER = D3D_TESSELLATOR_PARTITIONING.INTEGER,
    POW2 = D3D_TESSELLATOR_PARTITIONING.POW2,
    FRACTIONAL_ODD = D3D_TESSELLATOR_PARTITIONING.FRACTIONAL_ODD,
    FRACTIONAL_EVEN = D3D_TESSELLATOR_PARTITIONING.FRACTIONAL_EVEN,
}


enum D3D11_TESSELLATOR_OUTPUT_PRIMITIVE : uint
{
    UNDEFINED = D3D_TESSELLATOR_OUTPUT.UNDEFINED,
    POINT = D3D_TESSELLATOR_OUTPUT.POINT,
    LINE = D3D_TESSELLATOR_OUTPUT.LINE,
    TRIANGLE_CW = D3D_TESSELLATOR_OUTPUT.TRIANGLE_CW,
    TRIANGLE_CCW = D3D_TESSELLATOR_OUTPUT.TRIANGLE_CCW,
}
alias D3D11_TESSELLATOR_OUTPUT_PRIMITIVE D3D11_TESSELLATOR_OUTPUT;


/////////////////////////////////
//
// Microsoft was a bit lazy in migrating the whole SDK over to clean
// versions of 11 enums and data structures for all enums, structs,
// and interfaces, particularly with respect to D3D11Shader.h & D3D10Shader.h
//
// This library has fixed this problem for the sake of type safety on
// the allowable range of enum values, and various D3D10_* types 
// that appear in the D3D11 documentation need to be renamed to D3D11_*
// in user-code.  As D3D11 extends D3D10, this is a measure of safety
// if D3D11 D bindings are created, as it would be extremely easy
// to accidentally send D3D11 enum values to a D3D10 interface without
// this change.
//


enum D3D11_REGISTER_COMPONENT_TYPE : uint
{
    UNKNOWN = D3D_REGISTER_COMPONENT.UNKNOWN,
    UINT32 = D3D_REGISTER_COMPONENT.UINT32,
    SINT32 = D3D_REGISTER_COMPONENT.SINT32,
    FLOAT32 = D3D_REGISTER_COMPONENT.FLOAT32,
}
alias D3D11_REGISTER_COMPONENT_TYPE D3D11_REGISTER_COMPONENT;


enum D3D11_SHADER_INPUT_FLAGS : uint
{
    USERPACKED = D3D_SIF.USERPACKED,
    COMPARISON_SAMPLER = D3D_SIF.COMPARISON_SAMPLER,
    TEXTURE_COMPONENT_0 = D3D_SIF.TEXTURE_COMPONENT_0,
    TEXTURE_COMPONENT_1 = D3D_SIF.TEXTURE_COMPONENT_1,
    TEXTURE_COMPONENTS = D3D_SIF.TEXTURE_COMPONENTS,
}
alias D3D11_SHADER_INPUT_FLAGS D3D11_SIF;


enum D3D11_SHADER_INPUT_TYPE : uint
{
    CBUFFER = D3D_SIT.CBUFFER,
    TBUFFER = D3D_SIT.TBUFFER,
    TEXTURE = D3D_SIT.TEXTURE,
    SAMPLER = D3D_SIT.SAMPLER,
    UAV_RWTYPED = D3D_SIT.UAV_RWTYPED,
    STRUCTURED = D3D_SIT.STRUCTURED,
    UAV_RWSTRUCTURED = D3D_SIT.UAV_RWSTRUCTURED,
    BYTEADDRESS = D3D_SIT.BYTEADDRESS,
    UAV_RWBYTEADDRESS = D3D_SIT.UAV_RWBYTEADDRESS,
    UAV_APPEND_STRUCTURED = D3D_SIT.UAV_APPEND_STRUCTURED,
    UAV_CONSUME_STRUCTURED = D3D_SIT.UAV_CONSUME_STRUCTURED,
    UAV_RWSTRUCTURED_WITH_COUNTER = D3D_SIT.UAV_RWSTRUCTURED_WITH_COUNTER,
}
alias D3D11_SHADER_INPUT_TYPE D3D11_SIT;


enum D3D11_SHADER_CBUFFER_FLAGS : uint
{
    USERPACKED = D3D_CBF.USERPACKED,
}
alias D3D11_SHADER_CBUFFER_FLAGS D3D11_CBF;


enum D3D11_NAME : uint
{
    UNDEFINED = D3D_NAME.UNDEFINED,
    POSITION = D3D_NAME.POSITION,
    CLIP_DISTANCE = D3D_NAME.CLIP_DISTANCE,
    CULL_DISTANCE = D3D_NAME.CULL_DISTANCE,
    RENDER_TARGET_ARRAY_INDEX = D3D_NAME.RENDER_TARGET_ARRAY_INDEX,
    VIEWPORT_ARRAY_INDEX = D3D_NAME.VIEWPORT_ARRAY_INDEX,
    VERTEX_ID = D3D_NAME.VERTEX_ID,
    PRIMITIVE_ID = D3D_NAME.PRIMITIVE_ID,
    INSTANCE_ID = D3D_NAME.INSTANCE_ID,
    IS_FRONT_FACE = D3D_NAME.IS_FRONT_FACE,
    SAMPLE_INDEX = D3D_NAME.SAMPLE_INDEX,
    TARGET = D3D_NAME.TARGET,
    DEPTH = D3D_NAME.DEPTH,
    COVERAGE = D3D_NAME.COVERAGE,    
    FINAL_QUAD_EDGE_TESSFACTOR = D3D_NAME.FINAL_QUAD_EDGE_TESSFACTOR,
    FINAL_QUAD_INSIDE_TESSFACTOR = D3D_NAME.FINAL_QUAD_INSIDE_TESSFACTOR,
    FINAL_TRI_EDGE_TESSFACTOR = D3D_NAME.FINAL_TRI_EDGE_TESSFACTOR,
    FINAL_TRI_INSIDE_TESSFACTOR = D3D_NAME.FINAL_TRI_INSIDE_TESSFACTOR,
    FINAL_LINE_DETAIL_TESSFACTOR = D3D_NAME.FINAL_LINE_DETAIL_TESSFACTOR,
    FINAL_LINE_DENSITY_TESSFACTOR = D3D_NAME.FINAL_LINE_DENSITY_TESSFACTOR,
    DEPTH_GREATER_EQUAL = D3D_NAME.DEPTH_GREATER_EQUAL,
    DEPTH_LESS_EQUAL = D3D_NAME.DEPTH_LESS_EQUAL,
}


enum D3D11_SHADER_VARIABLE_CLASS : uint
{
    SCALAR = D3D_SVC.SCALAR,
    VECTOR = D3D_SVC.VECTOR,
    MATRIX_ROWS = D3D_SVC.MATRIX_ROWS,
    MATRIX_COLUMNS = D3D_SVC.MATRIX_COLUMNS,
    OBJECT = D3D_SVC.OBJECT,
    STRUCT = D3D_SVC.STRUCT,
    INTERFACE_CLASS = D3D_SVC.INTERFACE_CLASS,
    INTERFACE_POINTER = D3D_SVC.INTERFACE_POINTER,
}
alias D3D11_SHADER_VARIABLE_CLASS D3D11_SVC;


enum D3D11_SHADER_VARIABLE_FLAGS : uint
{
    USERPACKED = D3D_SVF.USERPACKED,
    SVF_USED = D3D_SVF.USED,
    INTERFACE_POINTER = D3D_SVF.INTERFACE_POINTER,
    INTERFACE_PARAMETER = D3D_SVF.INTERFACE_PARAMETER,
}
alias D3D11_SHADER_VARIABLE_FLAGS D3D11_SVF;


enum D3D11_SHADER_VARIABLE_TYPE : uint
{
    VOID = D3D_SVT.VOID,
    BOOL = D3D_SVT.BOOL,
    INT = D3D_SVT.INT,
    FLOAT = D3D_SVT.FLOAT,
    STRING = D3D_SVT.STRING,
    TEXTURE = D3D_SVT.TEXTURE,
    TEXTURE1D = D3D_SVT.TEXTURE1D,
    TEXTURE2D = D3D_SVT.TEXTURE2D,
    TEXTURE3D = D3D_SVT.TEXTURE3D,
    TEXTURECUBE = D3D_SVT.TEXTURECUBE,
    SAMPLER = D3D_SVT.SAMPLER,
    SAMPLER1D = D3D_SVT.SAMPLER1D,
    SAMPLER2D = D3D_SVT.SAMPLER2D,
    SAMPLER3D = D3D_SVT.SAMPLER3D,
    SAMPLERCUBE = D3D_SVT.SAMPLERCUBE,
    PIXELSHADER = D3D_SVT.PIXELSHADER,
    VERTEXSHADER = D3D_SVT.VERTEXSHADER,
    PIXELFRAGMENT = D3D_SVT.PIXELFRAGMENT,
    VERTEXFRAGMENT = D3D_SVT.VERTEXFRAGMENT,
    UINT = D3D_SVT.UINT,
    UINT8 = D3D_SVT.UINT8,
    GEOMETRYSHADER = D3D_SVT.GEOMETRYSHADER,
    RASTERIZER = D3D_SVT.RASTERIZER,
    DEPTHSTENCIL = D3D_SVT.DEPTHSTENCIL,
    BLEND = D3D_SVT.BLEND,
    BUFFER = D3D_SVT.BUFFER,
    CBUFFER = D3D_SVT.CBUFFER,
    TBUFFER = D3D_SVT.TBUFFER,
    TEXTURE1DARRAY = D3D_SVT.TEXTURE1DARRAY,
    TEXTURE2DARRAY = D3D_SVT.TEXTURE2DARRAY,
    RENDERTARGETVIEW = D3D_SVT.RENDERTARGETVIEW,
    DEPTHSTENCILVIEW = D3D_SVT.DEPTHSTENCILVIEW,
    TEXTURE2DMS = D3D_SVT.TEXTURE2DMS,
    TEXTURE2DMSARRAY = D3D_SVT.TEXTURE2DMSARRAY,
    TEXTURECUBEARRAY = D3D_SVT.TEXTURECUBEARRAY,
    HULLSHADER = D3D_SVT.HULLSHADER,
    DOMAINSHADER = D3D_SVT.DOMAINSHADER,
    INTERFACE_POINTER = D3D_SVT.INTERFACE_POINTER,
    COMPUTESHADER = D3D_SVT.COMPUTESHADER,
    DOUBLE = D3D_SVT.DOUBLE,
    RWTEXTURE1D = D3D_SVT.RWTEXTURE1D,
    RWTEXTURE1DARRAY = D3D_SVT.RWTEXTURE1DARRAY,
    RWTEXTURE2D = D3D_SVT.RWTEXTURE2D,
    RWTEXTURE2DARRAY = D3D_SVT.RWTEXTURE2DARRAY,
    RWTEXTURE3D = D3D_SVT.RWTEXTURE3D,
    RWBUFFER = D3D_SVT.RWBUFFER,
    BYTEADDRESS_BUFFER = D3D_SVT.BYTEADDRESS_BUFFER,
    RWBYTEADDRESS_BUFFER = D3D_SVT.RWBYTEADDRESS_BUFFER,
    STRUCTURED_BUFFER = D3D_SVT.STRUCTURED_BUFFER,
    RWSTRUCTURED_BUFFER = D3D_SVT.RWSTRUCTURED_BUFFER,
    APPEND_STRUCTURED_BUFFER = D3D_SVT.APPEND_STRUCTURED_BUFFER,
    CONSUME_STRUCTURED_BUFFER = D3D_SVT.CONSUME_STRUCTURED_BUFFER,
}
alias D3D11_SHADER_VARIABLE_TYPE D3D11_SVT;


/////////////////////////
// D3D11Shader Structs


struct D3D11_SHADER_BUFFER_DESC
{
    const char* Name;
    D3D11_CBUFFER_TYPE Type;
    uint Variables;
    uint Size;
    uint uFlags;
}


struct D3D11_SHADER_DESC
{
    uint Version;
    const char* Creator;
    uint Flags;
    uint ConstantBuffers;
    uint BoundResources;
    uint InputParameters;
    uint OutputParameters;
    uint InstructionCount;
    uint TempRegisterCount;
    uint TempArrayCount;
    uint DefCount;
    uint DclCount;
    uint TextureNormalInstructions;
    uint TextureLoadInstructions;
    uint TextureCompInstructions;
    uint TextureBiasInstructions;
    uint TextureGradientInstructions;
    uint FloatInstructionCount;
    uint IntInstructionCount;
    uint UintInstructionCount;
    uint StaticFlowControlCount;
    uint DynamicFlowControlCount;
    uint MacroInstructionCount;
    uint ArrayInstructionCount;
    uint CutInstructionCount;
    uint EmitInstructionCount;
    D3D11_PRIMITIVE_TOPOLOGY GSOutputTopology;
    uint GSMaxOutputVertexCount;
    D3D11_PRIMITIVE InputPrimitive;
    uint PatchConstantParameters;
    uint cGSInstanceCount;
    uint cControlPoints;
    D3D11_TESSELLATOR_OUTPUT_PRIMITIVE HSOutputPrimitive;
    D3D11_TESSELLATOR_PARTITIONING HSPartitioning;
    D3D11_TESSELLATOR_DOMAIN  TessellatorDomain;
    uint cBarrierInstructions;
    uint cInterlockedInstructions;
    uint cTextureStoreInstructions;
}


struct D3D11_SHADER_INPUT_BIND_DESC
{
    const char* Name;
    D3D11_SHADER_INPUT_TYPE Type;
    uint BindPoint;
    uint BindCount;
    uint uFlags;
    D3D11_RESOURCE_RETURN_TYPE ReturnType;
    D3D11_SRV_DIMENSION Dimension;
    uint NumSamples;
}


struct D3D11_SHADER_TYPE_DESC
{
    D3D11_SHADER_VARIABLE_CLASS Class;
    D3D11_SHADER_VARIABLE_TYPE Type;
    uint Rows;
    uint Columns;
    uint Elements;
    uint Members;
    uint Offset;
    const char* Name;
}


struct D3D11_SHADER_VARIABLE_DESC
{
    const char* Name;
    uint StartOffset;
    uint Size;
    uint uFlags;
    void* DefaultValue;
    uint StartTexture;
    uint TextureSize;
    uint StartSampler;
    uint SamplerSize;
}


struct D3D11_SIGNATURE_PARAMETER_DESC
{
    const char* SemanticName;
    uint SemanticIndex;
    uint Register;
    D3D11_NAME SystemValueType;
    D3D11_REGISTER_COMPONENT_TYPE ComponentType;
    ubyte Mask;
    ubyte ReadWriteMask;
    uint Stream;
}


/////////////////////////
// D3D11Shader Interfaces


// Guid for D wrapper
mixin(DX_DECLARE_IID("ID3D11ShaderReflectionType", "6E6FFA6A-9BAE-4613-A51E-91652D508C21"));
extern (C++)
{
// Note that ID3D11ShaderReflectionType does NOT inherit from IUnknown and is not a true COM interface
interface ID3D11ShaderReflectionType
{
extern(Windows):
    HRESULT GetDesc(
        D3D11_SHADER_TYPE_DESC* pDesc
        );
    ID3D11ShaderReflectionType GetMemberTypeByIndex(
        uint Index
        );
    ID3D11ShaderReflectionType GetMemberTypeByName(
        in char* Name
        );
    const char* GetMemberTypeName(
        uint Index
        );
    HRESULT IsEqual(
        ID3D11ShaderReflectionType pType
        );
    ID3D11ShaderReflectionType GetSubType(
        );
    ID3D11ShaderReflectionType GetBaseClass(
        );
    uint GetNumInterfaces(
        );
    ID3D11ShaderReflectionType GetInterfaceByIndex(
        uint uIndex
        );
    HRESULT IsOfType(
        ID3D11ShaderReflectionType pType
        );
    HRESULT ImplementsInterface(
        ID3D11ShaderReflectionType pBase
        );
}
}

                                                       
//mixin(DX_DECLARE_IID("ID3D11ShaderReflectionVariable", "51F23923-F3E5-4BD1-91CB-606177D8DB4C"));
extern(C++)
{
// Note that ID3D11ShaderReflectionVariable does NOT inherit from IUnknown and is not a true COM interface
interface ID3D11ShaderReflectionVariable
{
extern(Windows):
    HRESULT GetDesc(
        D3D11_SHADER_VARIABLE_DESC* pDesc
        );
    ID3D11ShaderReflectionType GetType(
        );
    ID3D11ShaderReflectionConstantBuffer GetBuffer(
        );
    uint GetInterfaceSlot(
        uint uArrayIndex
        );
}
}

                                                             
mixin(DX_DECLARE_IID("ID3D11ShaderReflectionConstantBuffer", "EB62D63D-93DD-4318-8AE8-C6F83AD371B8"));
extern (C++)
{
// Note that ID3D11ShaderReflectionConstantBuffer does NOT inherit from IUnknown and is not a true COM interface
interface ID3D11ShaderReflectionConstantBuffer
{
extern(Windows):
    HRESULT GetDesc(
        D3D11_SHADER_BUFFER_DESC* pDesc
        );
    ID3D11ShaderReflectionVariable GetVariableByIndex(
        uint Index
        );
    ID3D11ShaderReflectionVariable GetVariableByName(
        in char* Name
        );
}
}
                                               

version(DXSDK_11_0)
{
	mixin(DX_DECLARE_IID("ID3D11ShaderReflection", "0A233719-3960-4578-9D7C-203B8B1D9CC1"));
}
else version(DXSDK_11_1)
{
	mixin(DX_DECLARE_IID("ID3D11ShaderReflection", "8D536CA1-0CCA-4956-A837-786963755584"));
}
else
{
}
interface ID3D11ShaderReflection : IUnknown
{
extern(Windows):
    HRESULT GetDesc(
        D3D11_SHADER_DESC* pDesc
        );
    ID3D11ShaderReflectionConstantBuffer GetConstantBufferByIndex(
        uint Index
        );
    ID3D11ShaderReflectionConstantBuffer GetConstantBufferByName(
        in char* Name
        );
    HRESULT GetResourceBindingDesc(
        uint ResourceIndex,
        D3D11_SHADER_INPUT_BIND_DESC* pDesc
        );
    HRESULT GetInputParameterDesc(
        uint ParameterIndex,
        D3D11_SIGNATURE_PARAMETER_DESC* pDesc
        );
    HRESULT GetOutputParameterDesc(
        uint ParameterIndex,
        D3D11_SIGNATURE_PARAMETER_DESC* pDesc
        );
    HRESULT GetPatchConstantParameterDesc(
        uint ParameterIndex,
        D3D11_SIGNATURE_PARAMETER_DESC* pDesc
        );
    ID3D11ShaderReflectionVariable GetVariableByName(
        in char* Name
        );
    HRESULT GetResourceBindingDescByName(
        in char* Name,
        D3D11_SHADER_INPUT_BIND_DESC* pDesc
        );
    uint GetMovInstructionCount(
        );
    uint GetMovcInstructionCount(
        );
    uint GetConversionInstructionCount(
        );
    uint GetBitwiseInstructionCount(
        );
    D3D11_PRIMITIVE GetGSInputPrimitive(
        );
    BOOL IsSampleFrequencyShader(
        );
    uint GetNumInterfaceSlots(
        );
    HRESULT GetMinFeatureLevel(
        D3D11_FEATURE_LEVEL* pLevel
        );
    uint GetThreadGroupSize(
        uint* pSizeX,
        uint* pSizeY,
        uint* pSizeZ
        );
    version(DXSDK_11_1)
    {
		 ulong GetRequiresFlags();
    }
}


alias D3D_SHADER_MACRO D3D11_SHADER_MACRO;
alias IUnknown ID3DX11ThreadPump;   // This defined from D3DX11core, which is unsupported for the time being


extern(Windows)
{
version(DXSDK_11_0)
{
HRESULT D3DX11CompileFromFileA(
    in char* pSrcFile,
    in D3D11_SHADER_MACRO* pDefines,
    /*optional*/ ID3DInclude pInclude,
    in char* pFunctionName,
    in char* pProfile,
    UINT Flags1,
    UINT Flags2,
    ID3DX11ThreadPump pPump,
    out ID3D11Blob ppShader,
    /*optional*/ ID3D11Blob* ppErrorMsgs = null,
    /*optional*/ HRESULT* pHResult = null);

    
HRESULT D3DX11CompileFromFileW(
    in wchar* pSrcFile,
    in D3D11_SHADER_MACRO* pDefines,
    /*optional*/ ID3DInclude pInclude,
    in char* pFunctionName,
    in char* pProfile,
    UINT Flags1,
    UINT Flags2,
    ID3DX11ThreadPump pPump,
    out ID3D11Blob ppShader,
    /*optional*/ ID3D11Blob* ppErrorMsgs = null,
    /*optional*/ HRESULT* pHResult = null);

version(Unicode)
{
    alias D3DX11CompileFromFileW D3DX11CompileFromFile;
}
else
{
	alias D3DX11CompileFromFileA D3DX11CompileFromFile;
}
}


version(DXSDK_11_1)
{
HRESULT D3DCompileFromFile(
    in wchar* pSrcFile,
    in D3D11_SHADER_MACRO* pDefines,
    /*optional*/ ID3DInclude pInclude,
    in char* pFunctionName,
    in char* pProfile,
    UINT Flags1,
    UINT Flags2,
	out ID3D11Blob ppShader,
	/*optional*/ ID3D11Blob* ppErrorMsgs = null);
}
}

