// D Bindings for DirectX
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.dxpublic;


import win32.directx.dxinternal;


/////////////////////////
// D3D Common Structs


struct D3DVECTOR
{
    float x;
    float y;
    float z;
}


struct D3DCOLORVALUE
{
    float r;
    float g;
    float b;
    float a;
}


struct D3DRECT
{
    int x1;
    int y1;
    int x2;
    int y2;
}


struct D3DMATRIX
{
    union
    {
        struct
        {
            float _11, _12, _13, _14;
            float _21, _22, _23, _24;
            float _31, _32, _33, _34;
            float _41, _42, _43, _44;
        }
        float m[4][4];
    }
}


struct D2D_POINT_2U
{
    uint x;
    uint y;
}


struct D2D_POINT_2F
{
    float x;
    float y;
}


struct D2D_RECT_F
{
    float left;
    float top;
    float right;
    float bottom;
}


struct D2D_RECT_U
{
    uint left;
    uint top;
    uint right;
    uint bottom;
}


struct D2D_SIZE_F
{
    float width;
    float height;
}


struct D2D_SIZE_U
{
    uint width;
    uint height;
}


struct D2D_MATRIX_3X2_F
{
    float _11;
    float _12;
    float _21;
    float _22;
    float _31;
    float _32;
}


alias D3DCOLORVALUE D2D_COLOR_F;


struct D3D_SHADER_MACRO
{
    char* Name;
    char* Definition;
}


/////////////////////////
// D3D Common COM Interfaces


mixin(DX_DECLARE_IID("ID3DBlob",   "8BA5FB08-5195-40e2-AC58-0D989C3A0102"));
mixin(DX_DECLARE_IID("ID3D10Blob", "8BA5FB08-5195-40e2-AC58-0D989C3A0102"));
mixin(DX_DECLARE_IID("ID3D11Blob", "8BA5FB08-5195-40e2-AC58-0D989C3A0102"));
interface ID3DBlob : IUnknown
{
extern(Windows):
    void* GetBufferPointer(
        );
    size_t GetBufferSize(
        );
}
alias ID3DBlob ID3D10Blob;
alias ID3DBlob ID3D11Blob;


enum D3D_INCLUDE_TYPE : uint
{
    LOCAL = 0,
    SYSTEM = 1,
}
alias D3D_INCLUDE_TYPE D3D_INCLUDE;


// This interface is meant to be implemented by the directx developer
// in order to override the behavior of #include in HLSL shaders
interface ID3DInclude : IUnknown
{
extern(Windows):
    void Open(
        D3D_INCLUDE_TYPE IncludeType,
        in char* pFileName,
        in void* pParentData,
        const void** ppData,
        uint* pBytes
        );
    void Close(
        const void* pData
        );
}
