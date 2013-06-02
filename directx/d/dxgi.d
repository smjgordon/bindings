// D Bindings for DirectX
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.dxgi;


import win32.directx.dxinternal;
public import win32.directx.dxpublic;
import win32.windows;
import std.c.windows.com;


alias std.c.windows.com.IUnknown IUnknown;
alias std.c.windows.com.GUID GUID;
alias std.c.windows.com.IID IID;


version(DXSDK_11_0)
{
    pragma(lib, "dxgi.lib");
}
else version(DXSDK_11_1)
{
    pragma(lib, "dxgi.lib");
}
else
{
    static assert(false, "DirectX SDK version either unsupported or undefined");
}


/////////////////////////
// Sanity checks against canocial sizes from VS2010 C++ test applet

// Enums
static assert(DXGI_FORMAT.sizeof == 4);
static assert(DXGI_USAGE.sizeof == 4);
static assert(DXGI_MODE_SCANLINE_ORDER.sizeof == 4);
static assert(DXGI_MODE_SCALING.sizeof == 4);
static assert(DXGI_MODE_ROTATION.sizeof == 4);
static assert(DXGI_RESIDENCY.sizeof == 4);
static assert(DXGI_SWAP_EFFECT.sizeof == 4);
static assert(DXGI_SWAP_CHAIN_FLAG.sizeof == 4);
static assert(DXGI_ADAPTER_FLAG.sizeof == 4);

// Structs
version(X86)
{
static assert(DXGI_RGB.sizeof == 12);
static assert(DXGI_GAMMA_CONTROL.sizeof == 12324);
static assert(DXGI_GAMMA_CONTROL_CAPABILITIES.sizeof == 4116);
static assert(DXGI_RATIONAL.sizeof == 8);
static assert(DXGI_MODE_DESC.sizeof == 28);
static assert(DXGI_SAMPLE_DESC.sizeof == 8);
static assert(DXGI_FRAME_STATISTICS.sizeof == 32);
static assert(DXGI_MAPPED_RECT.sizeof == 8);
static assert(LUID.sizeof == 8);
static assert(DXGI_ADAPTER_DESC.sizeof == 292);
static assert(DXGI_OUTPUT_DESC.sizeof == 92);
static assert(DXGI_SHARED_RESOURCE.sizeof == 4);
static assert(DXGI_SURFACE_DESC.sizeof == 20);
static assert(DXGI_SWAP_CHAIN_DESC.sizeof == 60);
static assert(DXGI_ADAPTER_DESC1.sizeof == 296);
static assert(DXGI_DISPLAY_COLOR_SPACE.sizeof == 192);
}
version(X86_64)
{
static assert(DXGI_RGB.sizeof == 12);
static assert(DXGI_GAMMA_CONTROL.sizeof == 12324);
static assert(DXGI_GAMMA_CONTROL_CAPABILITIES.sizeof == 4116);
static assert(DXGI_RATIONAL.sizeof == 8);
static assert(DXGI_MODE_DESC.sizeof == 28);
static assert(DXGI_SAMPLE_DESC.sizeof == 8);
static assert(DXGI_FRAME_STATISTICS.sizeof == 32);
static assert(DXGI_MAPPED_RECT.sizeof == 16);
static assert(LUID.sizeof == 8);
static assert(DXGI_ADAPTER_DESC.sizeof == 304);
static assert(DXGI_OUTPUT_DESC.sizeof == 96);
static assert(DXGI_SHARED_RESOURCE.sizeof == 8);
static assert(DXGI_SURFACE_DESC.sizeof == 20);
static assert(DXGI_SWAP_CHAIN_DESC.sizeof == 72);
static assert(DXGI_ADAPTER_DESC1.sizeof == 312);
static assert(DXGI_DISPLAY_COLOR_SPACE.sizeof == 192);
}


/////////////////////////
// DXGI Templates


enum FACILITY_DXGI = 0x87a;
enum DXGI_MAX_SWAP_CHAIN_BUFFERS = 16;


template MAKE_HRESULT()
{
    HRESULT MAKE_HRESULT(uint sev, uint fac, uint code)
    {
        return cast(HRESULT)(((sev)<<31) | ((fac)<<16) | ((code)));
    }
}


template MAKE_DXGI_HRESULT()
{
    HRESULT MAKE_DXGI_HRESULT(uint code)
    {
        return MAKE_HRESULT(1, FACILITY_DXGI, code);
    }
}


template MAKE_DXGI_STATUS()
{
    HRESULT MAKE_DXGI_STATUS(uint code)
    {
        return MAKE_HRESULT(0, FACILITY_DXGI, code);
    }
}


/////////////////////////
// DXGI Enums


enum DXGI_STATUS_OCCLUDED = MAKE_DXGI_STATUS(1);
enum DXGI_STATUS_CLIPPED = MAKE_DXGI_STATUS(2);
enum DXGI_STATUS_NO_REDIRECTION = MAKE_DXGI_STATUS(4);
enum DXGI_STATUS_NO_DESKTOP_ACCESS = MAKE_DXGI_STATUS(5);
enum DXGI_STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE = MAKE_DXGI_STATUS(6);
enum DXGI_STATUS_MODE_CHANGED = MAKE_DXGI_STATUS(7);
enum DXGI_STATUS_MODE_CHANGE_IN_PROGRESS = MAKE_DXGI_STATUS(8);

enum DXGI_ERROR_INVALID_CALL = MAKE_DXGI_HRESULT(1);
enum DXGI_ERROR_NOT_FOUND = MAKE_DXGI_HRESULT(2);
enum DXGI_ERROR_MORE_DATA = MAKE_DXGI_HRESULT(3);
enum DXGI_ERROR_UNSUPPORTED = MAKE_DXGI_HRESULT(4);
enum DXGI_ERROR_DEVICE_REMOVED = MAKE_DXGI_HRESULT(5);
enum DXGI_ERROR_DEVICE_HUNG = MAKE_DXGI_HRESULT(6);
enum DXGI_ERROR_DEVICE_RESET = MAKE_DXGI_HRESULT(7);
enum DXGI_ERROR_WAS_STILL_DRAWING = MAKE_DXGI_HRESULT(10);
enum DXGI_ERROR_FRAME_STATISTICS_DISJOINT = MAKE_DXGI_HRESULT(11);
enum DXGI_ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE = MAKE_DXGI_HRESULT(12);
enum DXGI_ERROR_DRIVER_INTERNAL_ERROR = MAKE_DXGI_HRESULT(32);
enum DXGI_ERROR_NONEXCLUSIVE = MAKE_DXGI_HRESULT(33);
enum DXGI_ERROR_NOT_CURRENTLY_AVAILABLE = MAKE_DXGI_HRESULT(34);
enum DXGI_ERROR_REMOTE_CLIENT_DISCONNECTED = MAKE_DXGI_HRESULT(35);
enum DXGI_ERROR_REMOTE_OUTOFMEMORY = MAKE_DXGI_HRESULT(36);


enum DXGI_FORMAT : uint
{
    UNKNOWN                     = 0,
    R32G32B32A32_TYPELESS       = 1,
    R32G32B32A32_FLOAT          = 2,
    R32G32B32A32_UINT           = 3,
    R32G32B32A32_SINT           = 4,
    R32G32B32_TYPELESS          = 5,
    R32G32B32_FLOAT             = 6,
    R32G32B32_UINT              = 7,
    R32G32B32_SINT              = 8,
    R16G16B16A16_TYPELESS       = 9,
    R16G16B16A16_FLOAT          = 10,
    R16G16B16A16_UNORM          = 11,
    R16G16B16A16_UINT           = 12,
    R16G16B16A16_SNORM          = 13,
    R16G16B16A16_SINT           = 14,
    R32G32_TYPELESS             = 15,
    R32G32_FLOAT                = 16,
    R32G32_UINT                 = 17,
    R32G32_SINT                 = 18,
    R32G8X24_TYPELESS           = 19,
    D32_FLOAT_S8X24_UINT        = 20,
    R32_FLOAT_X8X24_TYPELESS    = 21,
    X32_TYPELESS_G8X24_UINT     = 22,
    R10G10B10A2_TYPELESS        = 23,
    R10G10B10A2_UNORM           = 24,
    R10G10B10A2_UINT            = 25,
    R11G11B10_FLOAT             = 26,
    R8G8B8A8_TYPELESS           = 27,
    R8G8B8A8_UNORM              = 28,
    R8G8B8A8_UNORM_SRGB         = 29,
    R8G8B8A8_UINT               = 30,
    R8G8B8A8_SNORM              = 31,
    R8G8B8A8_SINT               = 32,
    R16G16_TYPELESS             = 33,
    R16G16_FLOAT                = 34,
    R16G16_UNORM                = 35,
    R16G16_UINT                 = 36,
    R16G16_SNORM                = 37,
    R16G16_SINT                 = 38,
    R32_TYPELESS                = 39,
    D32_FLOAT                   = 40,
    R32_FLOAT                   = 41,
    R32_UINT                    = 42,
    R32_SINT                    = 43,
    R24G8_TYPELESS              = 44,
    D24_UNORM_S8_UINT           = 45,
    R24_UNORM_X8_TYPELESS       = 46,
    X24_TYPELESS_G8_UINT        = 47,
    R8G8_TYPELESS               = 48,
    R8G8_UNORM                  = 49,
    R8G8_UINT                   = 50,
    R8G8_SNORM                  = 51,
    R8G8_SINT                   = 52,
    R16_TYPELESS                = 53,
    R16_FLOAT                   = 54,
    D16_UNORM                   = 55,
    R16_UNORM                   = 56,
    R16_UINT                    = 57,
    R16_SNORM                   = 58,
    R16_SINT                    = 59,
    R8_TYPELESS                 = 60,
    R8_UNORM                    = 61,
    R8_UINT                     = 62,
    R8_SNORM                    = 63,
    R8_SINT                     = 64,
    A8_UNORM                    = 65,
    R1_UNORM                    = 66,
    R9G9B9E5_SHAREDEXP          = 67,
    R8G8_B8G8_UNORM             = 68,
    G8R8_G8B8_UNORM             = 69,
    BC1_TYPELESS                = 70,
    BC1_UNORM                   = 71,
    BC1_UNORM_SRGB              = 72,
    BC2_TYPELESS                = 73,
    BC2_UNORM                   = 74,
    BC2_UNORM_SRGB              = 75,
    BC3_TYPELESS                = 76,
    BC3_UNORM                   = 77,
    BC3_UNORM_SRGB              = 78,
    BC4_TYPELESS                = 79,
    BC4_UNORM                   = 80,
    BC4_SNORM                   = 81,
    BC5_TYPELESS                = 82,
    BC5_UNORM                   = 83,
    BC5_SNORM                   = 84,
    B5G6R5_UNORM                = 85,
    B5G5R5A1_UNORM              = 86,
    B8G8R8A8_UNORM              = 87,
    B8G8R8X8_UNORM              = 88,
    R10G10B10_XR_BIAS_A2_UNORM  = 89,
    B8G8R8A8_TYPELESS           = 90,
    B8G8R8A8_UNORM_SRGB         = 91,
    B8G8R8X8_TYPELESS           = 92,
    B8G8R8X8_UNORM_SRGB         = 93,
    BC6H_TYPELESS               = 94,
    BC6H_UF16                   = 95,
    BC6H_SF16                   = 96,
    BC7_TYPELESS                = 97,
    BC7_UNORM                   = 98,
    BC7_UNORM_SRGB              = 99,
}


enum DXGI_CPU_ACCESS : uint
{
    NONE = 0,
    DYNAMIC = 1,
    READ_WRITE = 2,
    SCRATCH = 3,
    FIELD = 15,
}


enum DXGI_USAGE : uint
{
    SHADER_INPUT         = 1L << (0 + 4),
    RENDER_TARGET_OUTPUT = 1L << (1 + 4),
    BACK_BUFFER          = 1L << (2 + 4),
    SHARED               = 1L << (3 + 4),
    READ_ONLY            = 1L << (4 + 4),
    DISCARD_ON_PRESENT   = 1L << (5 + 4),
    UNORDERED_ACCESS     = 1L << (6 + 4),
}


enum DXGI_MODE_SCANLINE_ORDER : uint
{
    UNSPECIFIED = 0,
    PROGRESSIVE = 1,
    UPPER_FIELD_FIRST = 2,
    LOWER_FIELD_FIRST = 3,
}


enum DXGI_MODE_SCALING : uint
{
    UNSPECIFIED = 0,
    CENTERED = 1,
    STRETCHED = 2,
}


enum DXGI_MODE_ROTATION : uint
{
    UNSPECIFIED = 0,
    IDENTITY = 1,
    ROTATE90 = 2,
    ROTATE180 = 3,
    ROTATE270 = 4,
}


enum DXGI_RESIDENCY : uint
{
    FULLY_RESIDENT = 1,
    RESIDENT_IN_SHARED_MEMORY = 2,
    EVICTED_TO_DISK = 3,
}


enum DXGI_SWAP_EFFECT : uint
{
    DISCARD = 0,
    SEQUENTIAL = 1,
}


enum DXGI_SWAP_CHAIN_FLAG : uint
{
    NONPREROTATED = 1,
    ALLOW_MODE_SWITCH = 2,
    GDI_COMPATIBLE = 4,
}
alias DXGI_SWAP_CHAIN_FLAG DXGI_SWAP_CHAIN;


enum DXGI_ADAPTER_FLAG : uint
{
   NONE = 0,
   REMOTE = 1,
}


enum DXGI_MAP : uint
{
    READ = 1,
    WRITE = 2,
    DISCARD = 4,
}


enum DXGI_RESOURCE_PRIORITY : uint
{
    PRIORITY_MINIMUM = 0x28000000,
    PRIORITY_LOW = 0x50000000,
    PRIORITY_NORMAL = 0x78000000,
    PRIORITY_HIGH = 0xA0000000,
    PRIORITY_MAXIMUM = 0xC8000000,
}


enum DXGI_ENUM_MODES : uint
{
    INTERLACED = 1,
    SCALING = 2,
}


enum DXGI_PRESENT : uint
{
    TEST = 1,
    DO_NOT_SEQUENCE = 2,
    RESTART = 4,
}


enum DXGI_MWA : uint
{
    NO_WINDOW_CHANGES = 1,
    NO_ALT_ENTER = 2,
    NO_PRINT_SCREEN = 4,
    VALID = NO_WINDOW_CHANGES | NO_ALT_ENTER | NO_PRINT_SCREEN,
}


/////////////////////////
// DXGI Structs


struct DXGI_RGB
{
    float Red;
    float Green;
    float Blue;
}


struct DXGI_GAMMA_CONTROL
{
    DXGI_RGB Scale;
    DXGI_RGB Offset;
    DXGI_RGB[1025] GammaCurve;
}


struct DXGI_GAMMA_CONTROL_CAPABILITIES
{
    BOOL ScaleAndOffsetSupported;
    float MaxConvertedValue;
    float MinConvertedValue;
    uint NumGammaControlPoints;
    float[1025] ControlPointPositions;
}


struct DXGI_RATIONAL
{
    uint Numerator;
    uint Denominator;
}


struct DXGI_MODE_DESC
{
    uint Width;
    uint Height;
    DXGI_RATIONAL RefreshRate;
    DXGI_FORMAT Format;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
}


struct DXGI_SAMPLE_DESC
{
    uint Count;
    uint Quality;
}


struct DXGI_FRAME_STATISTICS
{
    uint PresentCount;
    uint PresentRefreshCount;
    uint SyncRefreshCount;
    long SyncQPCTime;
    long SyncGPUTime;
}


struct DXGI_MAPPED_RECT
{
    int Pitch;
    ubyte* pBits;
}


struct LUID
{
    uint LowPart;
    int HighPart;
}


struct DXGI_ADAPTER_DESC
{
    wchar[128] Description;
    uint VendorId;
    uint DeviceId;
    uint SubSysId;
    uint Revision;
    size_t DedicatedVideoMemory;
    size_t DedicatedSystemMemory;
    size_t SharedSystemMemory;
    LUID AdapterLuid;
}


struct DXGI_OUTPUT_DESC
{
    wchar[32] DeviceName;
    RECT DesktopCoordinates;
    BOOL AttachedToDesktop;
    DXGI_MODE_ROTATION Rotation;
    HMONITOR Monitor;
}


struct DXGI_SHARED_RESOURCE
{
    HANDLE Handle;
}


struct DXGI_SURFACE_DESC
{
    uint Width;
    uint Height;
    DXGI_FORMAT Format;
    DXGI_SAMPLE_DESC SampleDesc;
}


struct DXGI_SWAP_CHAIN_DESC
{
    DXGI_MODE_DESC BufferDesc;
    DXGI_SAMPLE_DESC SampleDesc;
    DXGI_USAGE BufferUsage;
    uint BufferCount;
    HWND OutputWindow;
    BOOL Windowed;
    DXGI_SWAP_EFFECT SwapEffect;
    uint Flags;
}


struct DXGI_ADAPTER_DESC1
{
    wchar[128] Description;
    uint VendorId;
    uint DeviceId;
    uint SubSysId;
    uint Revision;
    size_t DedicatedVideoMemory;
    size_t DedicatedSystemMemory;
    size_t SharedSystemMemory;
    LUID AdapterLuid;
    uint Flags;
}


struct DXGI_DISPLAY_COLOR_SPACE
{
    float[8][2] PrimaryCoordinates;
    float[16][2] WhitePoints;
}


/////////////////////////
// DXGI Interfaces


mixin(DX_DECLARE_IID("IDXGIObject", "AEC22FB8-76F3-4639-9BE0-28EB43A67A2E"));
interface IDXGIObject : IUnknown
{
extern(Windows):
    HRESULT SetPrivateData(
        GUID* Name,
        uint DataSize,
        in void* pData
        );
    HRESULT SetPrivateDataInterface(
        GUID* Name,
        IUnknown pUnknown
        );
    HRESULT GetPrivateData(
        GUID* Name,
        uint* pDataSize,
        void* pData
        );
    HRESULT GetParent(
        in IID* riid,
        void** ppParent
        );
}


mixin(DX_DECLARE_IID("IDXGIDeviceSubObject", "3D3E0379-F9DE-4D58-BB6C-18D62992F1A6"));
interface IDXGIDeviceSubObject : IDXGIObject
{
extern(Windows):
    HRESULT GetDevice(
        IID* riid,
        void** ppDevice
        );
}


mixin(DX_DECLARE_IID("IDXGIResource", "035F3AB4-482E-4E50-B41F-8A7F8BD8960B"));
interface IDXGIResource : IDXGIDeviceSubObject
{
extern(Windows):
    HRESULT GetSharedHandle(
        out HANDLE pSharedHandle
        );
    HRESULT GetUsage(
        out DXGI_USAGE pUsage
        );
    HRESULT SetEvictionPriority(
        uint EvictionPriority
        );
    HRESULT GetEvictionPriority(
        out uint pEvictionPriority
        );
}


mixin(DX_DECLARE_IID("IDXGIKeyedMutex", "9D8E1289-D7B3-465F-8126-250E349AF85D"));
interface IDXGIKeyedMutex : IDXGIDeviceSubObject
{
extern(Windows):
    HRESULT AcquireSync(
        ulong Key,
        uint dwMilliseconds
        );
    HRESULT ReleaseSync(
        ulong Key
        );
}


mixin(DX_DECLARE_IID("IDXGISurface", "CAFCB56C-6AC3-4889-BF47-9E23BBD260EC"));
interface IDXGISurface : IDXGIDeviceSubObject
{
extern(Windows):
    HRESULT GetDesc(
        out DXGI_SURFACE_DESC pDesc
        );
    HRESULT Map(
        out DXGI_MAPPED_RECT pLockedRect,
        uint MapFlags
        );
    HRESULT Unmap(
        );
}


mixin(DX_DECLARE_IID("IDXGISurface1", "4AE63092-6327-4C1B-80AE-BFE12EA32B86"));
interface IDXGISurface1 : IDXGISurface
{
extern(Windows):
    HRESULT GetDC(
        BOOL Discard,
        out HDC phdc
        );
    HRESULT ReleaseDC(
        /*optional*/ RECT* pDirtyRect = null
        );
}


mixin(DX_DECLARE_IID("IDXGIAdapter", "2411E7E1-12AC-4CCF-BD14-9798E8534DC0"));
interface IDXGIAdapter : IDXGIObject
{
extern(Windows):
    HRESULT EnumOutputs(
        uint Output,
        out IDXGIOutput ppOutput
        );
    HRESULT GetDesc(
        out DXGI_ADAPTER_DESC pDesc
        );
    HRESULT CheckInterfaceSupport(
        GUID* InterfaceName,
        out long pUMDVersion
        );
}


mixin(DX_DECLARE_IID("IDXGIOutput", "AE02EEDB-C735-4690-8D52-5A8DC20213AA"));
interface IDXGIOutput : IDXGIObject
{
extern(Windows):
    HRESULT GetDesc(
        out DXGI_OUTPUT_DESC pDesc
        );
    HRESULT GetDisplayModeList(
        DXGI_FORMAT EnumFormat,
        uint Flags,
        uint* pNumModes,
        /*optional*/ DXGI_MODE_DESC* pDesc = null
        );
    HRESULT FindClosestMatchingMode(
        in DXGI_MODE_DESC* pModeToMatch,
        out DXGI_MODE_DESC pClosestMatch,
        /*optional*/ IUnknown pConcernedDevice = null);
    HRESULT WaitForVBlank(
        );
    HRESULT TakeOwnership(
        IUnknown pDevice,
        BOOL Exclusive
        );
    void ReleaseOwnership(
        );
    HRESULT GetGammaControlCapabilities(
        out DXGI_GAMMA_CONTROL_CAPABILITIES pGammaCaps
        );
    HRESULT SetGammaControl(
        in DXGI_GAMMA_CONTROL* pArray
        );
    HRESULT GetGammaControl(
        DXGI_GAMMA_CONTROL* pArray
        );
    HRESULT SetDisplaySurface(
        IDXGISurface pScanoutSurface
        );
    HRESULT GetDisplaySurfaceData(
        IDXGISurface pDestination
        );
    HRESULT GetFrameStatistics(
        out DXGI_FRAME_STATISTICS pStats
        );
}


mixin(DX_DECLARE_IID("IDXGISwapChain", "310D36A0-D2E7-4C0A-AA04-6A9D23B8886A"));
interface IDXGISwapChain : IDXGIDeviceSubObject
{
extern(Windows):
    HRESULT Present(
        uint SyncInterval,
        uint Flags
        );
    HRESULT GetBuffer(
        uint Buffer,
        IID* riid,
        void** ppSurface
        );
    HRESULT SetFullscreenState(
        BOOL Fullscreen,
        /*optional*/ IDXGIOutput pTarget = null
        );
    HRESULT GetFullscreenState(
        out BOOL pFullscreen,
        out IDXGIOutput ppTarget
        );
    HRESULT GetDesc(
        out DXGI_SWAP_CHAIN_DESC pDesc
        );
    HRESULT ResizeBuffers(
        uint BufferCount,
        uint Width,
        uint Height,
        DXGI_FORMAT NewFormat,
        uint SwapChainFlags
        );
    HRESULT ResizeTarget(
        in DXGI_MODE_DESC* pNewTargetParameters
        );
    HRESULT GetContainingOutput(
        out IDXGIOutput ppOutput
        );
    HRESULT GetFrameStatistics(
        out DXGI_FRAME_STATISTICS pStats
        );
    HRESULT GetLastPresentCount(
        out uint pLastPresentCount
        );
}


mixin(DX_DECLARE_IID("IDXGIFactory", "7B7166EC-21C7-44AE-B21A-C9AE321AE369"));
interface IDXGIFactory : IDXGIObject
{
extern(Windows):
    HRESULT EnumAdapters(
        uint Adapter,
        out IDXGIAdapter ppAdapter
        );
    HRESULT MakeWindowAssociation(
        HWND WindowHandle,
        uint Flags);
    HRESULT GetWindowAssociation(
        out HWND pWindowHandle
        );
    HRESULT CreateSwapChain(
        IUnknown pDevice,
        DXGI_SWAP_CHAIN_DESC* pDesc,
        out IDXGISwapChain ppSwapChain
        );
    HRESULT CreateSoftwareAdapter(
        HMODULE Module,
        out IDXGIAdapter ppAdapter
        );
}


mixin(DX_DECLARE_IID("IDXGIDevice", "54EC77FA-1377-44E6-8C32-88FD5F44C84C"));
interface IDXGIDevice : IDXGIObject
{
extern(Windows):
    HRESULT GetAdapter(
        out IDXGIAdapter pAdapter
        );
    HRESULT CreateSurface(
        in DXGI_SURFACE_DESC* pDesc,
        uint NumSurfaces,
        DXGI_USAGE Usage,
        in DXGI_SHARED_RESOURCE* pSharedResource,
        out IDXGISurface ppSurface
        );
    HRESULT QueryResourceResidency(
        IUnknown* ppResourcesArray,
        DXGI_RESIDENCY* pResidencyStatusArray,
        uint NumResources
        );
    HRESULT SetGPUThreadPriority(
        int Priority
        );
    HRESULT GetGPUThreadPriority(
        out int pPriority
        );
}


mixin(DX_DECLARE_IID("IDXGIFactory1", "770AAE78-F26F-4DBA-A829-253C83D1B387"));
interface IDXGIFactory1 : IDXGIFactory
{
extern(Windows):
    HRESULT EnumAdapters1(
        uint Adapter,
        out IDXGIAdapter1 ppAdapter
        );
    BOOL IsCurrent(
        );
}


mixin(DX_DECLARE_IID("IDXGIAdapter1", "29038F61-3839-4626-91FD-086879011A05"));
interface IDXGIAdapter1 : IDXGIAdapter
{
extern(Windows):
    HRESULT GetDesc1(
        out DXGI_ADAPTER_DESC1 pDesc
        );
}


mixin(DX_DECLARE_IID("IDXGIDevice1", "77DB970F-6276-48BA-BA28-070143B4392C"));
interface IDXGIDevice1 : IDXGIDevice
{
extern(Windows):
    HRESULT SetMaximumFrameLatency(
        uint MaxLatency
        );
    HRESULT GetMaximumFrameLatency(
        out uint pMaxLatency
        );
}



extern(Windows)
{
    HRESULT CreateDXGIFactory(in IID* riid, void** ppFactory);
    HRESULT CreateDXGIFactory1(in IID* riid, void** ppFactory);
}
