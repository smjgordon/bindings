// D Bindings for Direct2D1
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.d2d1;


import win32.directx.dxinternal;
public import win32.directx.dxpublic;
import win32.directx.dxgi;
import win32.directx.dwrite;
import std.c.windows.com;
import win32.windows;


alias std.c.windows.com.IUnknown IUnknown;
alias std.c.windows.com.GUID GUID;
alias std.c.windows.com.IID IID;


// d2d has indirect dependencies on the d3d and dxgi base types and values
version(DXSDK_11_0)
{
}
else version(DXSDK_11_1)
{
}
else
{
    static assert(false, "DirectX SDK version either unsupported or undefined");
}


/////////////////////////
// Sanity checks against canocial sizes from VS2010 C++ test applet

// Enums
static assert(D2D1_ALPHA_MODE.sizeof == 4);
static assert(D2D1_GAMMA.sizeof == 4);
static assert(D2D1_OPACITY_MASK_CONTENT.sizeof == 4);
static assert(D2D1_EXTEND_MODE.sizeof == 4);
static assert(D2D1_ANTIALIAS_MODE.sizeof == 4);
static assert(D2D1_TEXT_ANTIALIAS_MODE.sizeof == 4);
static assert(D2D1_BITMAP_INTERPOLATION_MODE.sizeof == 4);
static assert(D2D1_DRAW_TEXT_OPTIONS.sizeof == 4);
static assert(D2D1_ARC_SIZE.sizeof == 4);
static assert(D2D1_CAP_STYLE.sizeof == 4);
static assert(D2D1_DASH_STYLE.sizeof == 4);
static assert(D2D1_LINE_JOIN.sizeof == 4);
static assert(D2D1_COMBINE_MODE.sizeof == 4);
static assert(D2D1_GEOMETRY_RELATION.sizeof == 4);
static assert(D2D1_GEOMETRY_SIMPLIFICATION_OPTION.sizeof == 4);
static assert(D2D1_FIGURE_BEGIN.sizeof == 4);
static assert(D2D1_FIGURE_END.sizeof == 4);
static assert(D2D1_PATH_SEGMENT.sizeof == 4);
static assert(D2D1_SWEEP_DIRECTION.sizeof == 4);
static assert(D2D1_FILL_MODE.sizeof == 4);
static assert(D2D1_LAYER_OPTIONS.sizeof == 4);
static assert(D2D1_WINDOW_STATE.sizeof == 4);
static assert(D2D1_RENDER_TARGET_TYPE.sizeof == 4);
static assert(D2D1_FEATURE_LEVEL.sizeof == 4);
static assert(D2D1_RENDER_TARGET_USAGE.sizeof == 4);
static assert(D2D1_PRESENT_OPTIONS.sizeof == 4);
static assert(D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS.sizeof == 4);
static assert(D2D1_DC_INITIALIZE_MODE.sizeof == 4);
static assert(D2D1_DEBUG_LEVEL.sizeof == 4);
static assert(D2D1_FACTORY_TYPE.sizeof == 4);

// Structs 
version(X86)
{
static assert(D2D1_PIXEL_FORMAT.sizeof == 8);
static assert(D2D1_BITMAP_PROPERTIES.sizeof == 16);
static assert(D2D1_GRADIENT_STOP.sizeof == 20);
static assert(D2D1_BRUSH_PROPERTIES.sizeof == 28);
static assert(D2D1_BITMAP_BRUSH_PROPERTIES.sizeof == 12);
static assert(D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES.sizeof == 16);
static assert(D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES.sizeof == 24);
static assert(D2D1_BEZIER_SEGMENT.sizeof == 24);
static assert(D2D1_TRIANGLE.sizeof == 24);
static assert(D2D1_ARC_SEGMENT.sizeof == 28);
static assert(D2D1_QUADRATIC_BEZIER_SEGMENT.sizeof == 16);
static assert(D2D1_ELLIPSE.sizeof == 16);
static assert(D2D1_ROUNDED_RECT.sizeof == 24);
static assert(D2D1_STROKE_STYLE_PROPERTIES.sizeof == 28);
static assert(D2D1_LAYER_PARAMETERS.sizeof == 60);
static assert(D2D1_RENDER_TARGET_PROPERTIES.sizeof == 28);
static assert(D2D1_HWND_RENDER_TARGET_PROPERTIES.sizeof == 16);
static assert(D2D1_DRAWING_STATE_DESCRIPTION.sizeof == 48);
static assert(D2D1_FACTORY_OPTIONS.sizeof == 4);
}
version(X86_64)
{
static assert(D2D1_PIXEL_FORMAT.sizeof == 8);
static assert(D2D1_BITMAP_PROPERTIES.sizeof == 16);
static assert(D2D1_GRADIENT_STOP.sizeof == 20);
static assert(D2D1_BRUSH_PROPERTIES.sizeof == 28);
static assert(D2D1_BITMAP_BRUSH_PROPERTIES.sizeof == 12);
static assert(D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES.sizeof == 16);
static assert(D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES.sizeof == 24);
static assert(D2D1_BEZIER_SEGMENT.sizeof == 24);
static assert(D2D1_TRIANGLE.sizeof == 24);
static assert(D2D1_ARC_SEGMENT.sizeof == 28);
static assert(D2D1_QUADRATIC_BEZIER_SEGMENT.sizeof == 16);
static assert(D2D1_ELLIPSE.sizeof == 16);
static assert(D2D1_ROUNDED_RECT.sizeof == 24);
static assert(D2D1_STROKE_STYLE_PROPERTIES.sizeof == 28);
static assert(D2D1_LAYER_PARAMETERS.sizeof == 72);
static assert(D2D1_RENDER_TARGET_PROPERTIES.sizeof == 28);
static assert(D2D1_HWND_RENDER_TARGET_PROPERTIES.sizeof == 24);
static assert(D2D1_DRAWING_STATE_DESCRIPTION.sizeof == 48);
static assert(D2D1_FACTORY_OPTIONS.sizeof == 4);
}


/////////////////////////
// wincodec 'WIC'
interface IWICBitmap : IUnknown
{
}
interface IWICBitmapSource : IUnknown
{
}
// wincodec
/////////////////////////


/////////////////////////
// D2D1 Enums


enum D2D1_INVALID_TAG = ulong.max;
enum D2D1_DEFAULT_FLATTENING_TOLERANCE = 0.25f;


enum D2D1_ALPHA_MODE : uint
{
    UNKNOWN = 0,
    PREMULTIPLIED = 1,
    STRAIGHT = 2,
    IGNORE = 3,
}


enum D2D1_GAMMA : uint
{
    D2D1_GAMMA_2_2 = 0,
    D2D1_GAMMA_1_0 = 1,
}


enum D2D1_OPACITY_MASK_CONTENT : uint
{
    GRAPHICS = 0,
    TEXT_NATURAL = 1,
    TEXT_GDI_COMPATIBLE = 2,
}


enum D2D1_EXTEND_MODE : uint
{
    CLAMP = 0,
    WRAP = 1,
    MIRROR = 2,
}


enum D2D1_ANTIALIAS_MODE : uint
{
    PER_PRIMITIVE = 0,
    ALIASED = 1,
}


enum D2D1_TEXT_ANTIALIAS_MODE : uint
{
    DEFAULT = 0,
    CLEARTYPE = 1,
    GRAYSCALE = 2,
    ALIASED = 3,
}


enum D2D1_BITMAP_INTERPOLATION_MODE : uint
{
    NEAREST_NEIGHBOR = 0,
    LINEAR = 1,
}


enum D2D1_DRAW_TEXT_OPTIONS : uint
{
    NO_SNAP = 0x00000001,
    CLIP = 0x00000002,
    NONE = 0x00000000,
}


enum D2D1_ARC_SIZE : uint
{
    SMALL = 0,
    LARGE = 1,
}


enum D2D1_CAP_STYLE : uint
{
    FLAT = 0,
    SQUARE = 1,
    ROUND = 2,
    TRIANGLE = 3,
}


enum D2D1_DASH_STYLE : uint
{
    SOLID = 0,
    DASH = 1,
    DOT = 2,
    DASH_DOT = 3,
    DASH_DOT_DOT = 4,
    CUSTOM = 5,
}


enum D2D1_LINE_JOIN : uint
{
    MITER = 0,
    BEVEL = 1,
    ROUND = 2,
    MITER_OR_BEVEL = 3,
}


enum D2D1_COMBINE_MODE : uint
{
    UNION = 0,
    INTERSECT = 1,
    XOR = 2,
    EXCLUDE = 3,
}


enum D2D1_GEOMETRY_RELATION : uint
{
    UNKNOWN = 0,
    DISJOINT = 1,
    IS_CONTAINED = 2,
    CONTAINS = 3,
    OVERLAP = 4,
}


enum D2D1_GEOMETRY_SIMPLIFICATION_OPTION : uint
{
    CUBICS_AND_LINES = 0,
    LINES = 1,
}


enum D2D1_FIGURE_BEGIN : uint
{
    FILLED = 0,
    HOLLOW = 1,
}


enum D2D1_FIGURE_END : uint
{
    OPEN = 0,
    CLOSED = 1,
}


enum D2D1_PATH_SEGMENT : uint
{
    NONE = 0x00000000,
    FORCE_UNSTROKED = 0x00000001,
    FORCE_ROUND_LINE_JOIN = 0x00000002,
}


enum D2D1_SWEEP_DIRECTION : uint
{
    COUNTER_CLOCKWISE = 0,
    CLOCKWISE = 1,
}


enum D2D1_FILL_MODE : uint
{
    ALTERNATE = 0,
    WINDING = 1,
}


enum D2D1_LAYER_OPTIONS : uint
{
    NONE = 0x00000000,
    INITIALIZE_FOR_CLEARTYPE = 0x00000001,
}


enum D2D1_WINDOW_STATE : uint
{
    NONE = 0x0000000,
    OCCLUDED = 0x0000001,
}


enum D2D1_RENDER_TARGET_TYPE : uint
{
    DEFAULT = 0,
    SOFTWARE = 1,
    HARDWARE = 2,
}


enum D2D1_FEATURE_LEVEL : uint
{
    LEVEL_DEFAULT = 0,
    LEVEL_9 = 0x9100,
    LEVEL_10 = 0xA000,
}
alias D2D1_FEATURE_LEVEL D2D1_FEATURE;


enum D2D1_RENDER_TARGET_USAGE : uint
{
    NONE = 0x00000000,
    FORCE_BITMAP_REMOTING = 0x00000001,
    GDI_COMPATIBLE = 0x00000002,
}


enum D2D1_PRESENT_OPTIONS : uint
{
    NONE = 0x00000000,
    RETAIN_CONTENTS = 0x00000001,
    IMMEDIATELY = 0x00000002,
}


enum D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS : uint
{
    NONE = 0x00000000,
    GDI_COMPATIBLE = 0x00000001,
}


enum D2D1_DC_INITIALIZE_MODE : uint
{
    COPY = 0,
    CLEAR = 1,
}


enum D2D1_DEBUG_LEVEL : uint
{
    NONE = 0,
    ERROR = 1,
    WARNING = 2,
    INFORMATION = 3,
}


enum D2D1_FACTORY_TYPE : uint
{
    SINGLE_THREADED = 0,
    MULTI_THREADED = 1,
}


/////////////////////////
// D2D1 Structs


struct D2D1_PIXEL_FORMAT
{
    DXGI_FORMAT format;
    D2D1_ALPHA_MODE alphaMode;
}


struct D2D1_BITMAP_PROPERTIES
{
    D2D1_PIXEL_FORMAT pixelFormat;
    float dpiX;
    float dpiY;
}


struct D2D1_GRADIENT_STOP
{
    float position;
    D2D1_COLOR_F color;
}


struct D2D1_BRUSH_PROPERTIES
{
    float opacity;
    D2D1_MATRIX_3X2_F transform;
}


struct D2D1_BITMAP_BRUSH_PROPERTIES
{
    D2D1_EXTEND_MODE extendModeX;
    D2D1_EXTEND_MODE extendModeY;
    D2D1_BITMAP_INTERPOLATION_MODE interpolationMode;
}


struct D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES
{
    D2D1_POINT_2F startPoint;
    D2D1_POINT_2F endPoint;
}


struct D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES
{
    D2D1_POINT_2F center;
    D2D1_POINT_2F gradientOriginOffset;
    float radiusX;
    float radiusY;
}


struct D2D1_BEZIER_SEGMENT
{
    D2D1_POINT_2F point1;
    D2D1_POINT_2F point2;
    D2D1_POINT_2F point3;
}


struct D2D1_TRIANGLE
{
    D2D1_POINT_2F point1;
    D2D1_POINT_2F point2;
    D2D1_POINT_2F point3;
}


struct D2D1_ARC_SEGMENT
{
    D2D1_POINT_2F point;
    D2D1_SIZE_F size;
    float rotationAngle;
    D2D1_SWEEP_DIRECTION sweepDirection;
    D2D1_ARC_SIZE arcSize;
}


struct D2D1_QUADRATIC_BEZIER_SEGMENT
{
    D2D1_POINT_2F point1;
    D2D1_POINT_2F point2;
}


struct D2D1_ELLIPSE
{
    D2D1_POINT_2F point;
    float radiusX;
    float radiusY;
}


struct D2D1_ROUNDED_RECT
{
    D2D1_RECT_F rect;
    float radiusX;
    float radiusY;
}


struct D2D1_STROKE_STYLE_PROPERTIES
{
    D2D1_CAP_STYLE startCap;
    D2D1_CAP_STYLE endCap;
    D2D1_CAP_STYLE dashCap;
    D2D1_LINE_JOIN lineJoin;
    float miterLimit;
    D2D1_DASH_STYLE dashStyle;
    float dashOffset;
}


struct D2D1_LAYER_PARAMETERS
{
    D2D1_RECT_F contentBounds;
    ID2D1Geometry geometricMask;
    D2D1_ANTIALIAS_MODE maskAntialiasMode;
    D2D1_MATRIX_3X2_F maskTransform;
    float opacity;
    ID2D1Brush opacityBrush;
    D2D1_LAYER_OPTIONS layerOptions;
}


struct D2D1_RENDER_TARGET_PROPERTIES
{
    D2D1_RENDER_TARGET_TYPE type;
    D2D1_PIXEL_FORMAT pixelFormat;
    float dpiX;
    float dpiY;
    D2D1_RENDER_TARGET_USAGE usage;
    D2D1_FEATURE_LEVEL minLevel;
}


struct D2D1_HWND_RENDER_TARGET_PROPERTIES
{
    HWND hwnd;
    D2D1_SIZE_U pixelSize;
    D2D1_PRESENT_OPTIONS presentOptions;
}


struct D2D1_DRAWING_STATE_DESCRIPTION
{
    D2D1_ANTIALIAS_MODE antialiasMode;
    D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode;
    D2D1_TAG tag1;
    D2D1_TAG tag2;
    D2D1_MATRIX_3X2_F transform;
}


struct D2D1_FACTORY_OPTIONS
{
    D2D1_DEBUG_LEVEL debugLevel;
}


alias D2D_POINT_2U D2D1_POINT_2U;
alias D2D_POINT_2F D2D1_POINT_2F;
alias D2D_RECT_F D2D1_RECT_F;
alias D2D_RECT_U D2D1_RECT_U;
alias D2D_SIZE_F D2D1_SIZE_F;
alias D2D_SIZE_U D2D1_SIZE_U;
alias D2D_COLOR_F D2D1_COLOR_F;
alias D2D_MATRIX_3X2_F D2D1_MATRIX_3X2_F;
alias ulong D2D1_TAG;


/////////////////////////
// D2D1 Interfaces


mixin(DX_DECLARE_IID("ID2D1Resource", "2CD90691-12E2-11DC-9FED-001143A055F9"));
interface ID2D1Resource : IUnknown
{
extern(Windows):
    void GetFactory( out ID2D1Factory factory );
}


mixin(DX_DECLARE_IID("ID2D1Bitmap", "A2296057-EA42-4099-983B-539FB6505426"));
interface ID2D1Bitmap : ID2D1Resource
{
extern(Windows):
    D2D1_SIZE_F GetSize(
        );
    D2D1_SIZE_U GetPixelSize(
        );
    D2D1_PIXEL_FORMAT GetPixelFormat(
        );
    void GetDpi(
        out float dpiX,
        out float dpiY
        );
    HRESULT CopyFromBitmap(
        in D2D1_POINT_2U* destPoint,
        ID2D1Bitmap bitmap,
        in D2D1_RECT_U* srcRect 
        );
    HRESULT CopyFromRenderTarget(
        in D2D1_POINT_2U* destPoint,
        ID2D1RenderTarget renderTarget,
        in D2D1_RECT_U* srcRect 
        );
    HRESULT CopyFromMemory(
        in D2D1_RECT_U* dstRect,
        in void* srcData,
        uint pitch 
        );
}


mixin(DX_DECLARE_IID("ID2D1GradientStopCollection", "2CD906A7-12E2-11DC-9FED-001143A055F9"));
interface ID2D1GradientStopCollection  : ID2D1Resource
{
extern(Windows):
    uint GetGradientStopCount(
        );
    void GetGradientStops(
        D2D1_GRADIENT_STOP* gradientStops,
        uint gradientStopsCount 
        );
    D2D1_GAMMA GetColorInterpolationGamma(
        );
    D2D1_EXTEND_MODE GetExtendMode(
        );
}



mixin(DX_DECLARE_IID("ID2D1Brush", "2CD906A8-12E2-11DC-9FED-001143A055F9"));
interface ID2D1Brush : ID2D1Resource
{
extern(Windows):
    void SetOpacity(
        float opacity 
        );
    void SetTransform(
        in D2D1_MATRIX_3X2_F* transform 
        );
    float GetOpacity(
        );
    void GetTransform(
        out D2D1_MATRIX_3X2_F transform 
        );
}


mixin(DX_DECLARE_IID("ID2D1BitmapBrush", "2CD906AA-12E2-11DC-9FED-001143A055F9"));
interface ID2D1BitmapBrush : ID2D1Brush
{
extern(Windows):
    void SetExtendModeX(
        D2D1_EXTEND_MODE extendModeX 
        );
    void SetExtendModeY(
        D2D1_EXTEND_MODE extendModeY 
        );
    void SetInterpolationMode(
        D2D1_BITMAP_INTERPOLATION_MODE interpolationMode 
        );
    void SetBitmap(
        ID2D1Bitmap bitmap 
        );
    D2D1_EXTEND_MODE GetExtendModeX(
        );
    D2D1_EXTEND_MODE GetExtendModeY(
        );
    D2D1_BITMAP_INTERPOLATION_MODE GetInterpolationMode(
        );
    void GetBitmap(
        out ID2D1Bitmap bitmap 
        );
}


mixin(DX_DECLARE_IID("ID2D1SolidColorBrush", "2CD906A9-12E2-11DC-9FED-001143A055F9"));
interface ID2D1SolidColorBrush : ID2D1Brush
{
extern(Windows):
    void SetColor(
        in D2D1_COLOR_F* color 
        );
    D2D1_COLOR_F GetColor(
        );
}


mixin(DX_DECLARE_IID("ID2D1LinearGradientBrush", "2CD906AB-12E2-11DC-9FED-001143A055F9"));
interface ID2D1LinearGradientBrush : ID2D1Brush
{
extern(Windows):
    void SetStartPoint(
        D2D1_POINT_2F startPoint 
        );
    void SetEndPoint(
        D2D1_POINT_2F endPoint 
        );
    D2D1_POINT_2F GetStartPoint(
        );
    D2D1_POINT_2F GetEndPoint(
        );
    void GetGradientStopCollection(
        out ID2D1GradientStopCollection gradientStopCollection 
        );
}


mixin(DX_DECLARE_IID("ID2D1RadialGradientBrush", "2CD906AC-12E2-11DC-9FED-001143A055F9"));
interface ID2D1RadialGradientBrush : ID2D1Brush
{
extern(Windows):
    void SetCenter(
        D2D1_POINT_2F center 
        );
    void SetGradientOriginOffset(
        D2D1_POINT_2F gradientOriginOffset 
        );
    void SetRadiusX(
        float radiusX 
        );
    void SetRadiusY(
        float radiusY 
        );
    D2D1_POINT_2F GetCenter(
        );
    D2D1_POINT_2F GetGradientOriginOffset(
        );
    float GetRadiusX(
        );
    float GetRadiusY(
        );
    void GetGradientStopCollection(
        out ID2D1GradientStopCollection gradientStopCollection 
        );
}


mixin(DX_DECLARE_IID("ID2D1StrokeStyle", "2CD9069D-12E2-11DC-9FED-001143A055F9"));
interface ID2D1StrokeStyle : ID2D1Resource
{
extern(Windows):
    D2D1_CAP_STYLE GetStartCap(
        );
    D2D1_CAP_STYLE GetEndCap(
        );
    D2D1_CAP_STYLE GetDashCap(
        );
    float GetMiterLimit(
        );
    D2D1_LINE_JOIN GetLineJoin(
        );
    float GetDashOffset(
        );
    D2D1_DASH_STYLE GetDashStyle(
        );
    uint GetDashesCount(
        );
    void GetDashes(
        float* dashes,
        uint dashesCount 
        );
}


mixin(DX_DECLARE_IID("ID2D1Geometry", "2CD906A1-12E2-11DC-9FED-001143A055F9"));
interface ID2D1Geometry : ID2D1Resource
{
extern(Windows):
    HRESULT GetBounds(
        in D2D1_MATRIX_3X2_F* worldTransform,
        out D2D1_RECT_F bounds 
        );
    HRESULT GetWidenedBounds(
        float strokeWidth,
        /*optional*/ ID2D1StrokeStyle strokeStyle,
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        out D2D1_RECT_F bounds 
        );
    HRESULT StrokeContainsPoint(
        D2D1_POINT_2F point,
        float strokeWidth,
        /*optional*/ ID2D1StrokeStyle strokeStyle,
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        out BOOL contains 
        );
    HRESULT FillContainsPoint(
        D2D1_POINT_2F point,
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        out BOOL contains 
        );
    HRESULT CompareWithGeometry(
        ID2D1Geometry inputGeometry,
        in D2D1_MATRIX_3X2_F* inputGeometryTransform,
        float flatteningTolerance,
        out D2D1_GEOMETRY_RELATION relation 
        );
    HRESULT Simplify(
        D2D1_GEOMETRY_SIMPLIFICATION_OPTION simplificationOption,
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        ID2D1SimplifiedGeometrySink geometrySink 
        );
    HRESULT Tessellate(
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        ID2D1TessellationSink tessellationSink 
        );
    HRESULT CombineWithGeometry(
        ID2D1Geometry inputGeometry,
        D2D1_COMBINE_MODE combineMode,
        in D2D1_MATRIX_3X2_F* inputGeometryTransform,
        float flatteningTolerance,
        ID2D1SimplifiedGeometrySink geometrySink 
        );
    HRESULT Outline(
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        ID2D1SimplifiedGeometrySink geometrySink 
        );
    HRESULT ComputeArea(
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        out float area 
        );
    HRESULT ComputeLength(
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        out float length 
        );
    HRESULT ComputePointAtLength(
        float length,
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        D2D1_POINT_2F* point,
        D2D1_POINT_2F* unitTangentVector 
        );
    HRESULT Widen(
        float strokeWidth,
        /*optional*/ ID2D1StrokeStyle strokeStyle,
        in D2D1_MATRIX_3X2_F* worldTransform,
        float flatteningTolerance,
        ID2D1SimplifiedGeometrySink geometrySink 
        );
}


mixin(DX_DECLARE_IID("ID2D1RectangleGeometry", "2CD906A2-12E2-11DC-9FED-001143A055F9"));
interface ID2D1RectangleGeometry : ID2D1Geometry
{
extern(Windows):
    void GetRect(
        out D2D1_RECT_F rect 
        );
}


mixin(DX_DECLARE_IID("ID2D1RoundedRectangleGeometry", "2CD906A3-12E2-11DC-9FED-001143A055F9"));
interface ID2D1RoundedRectangleGeometry : ID2D1Geometry
{
extern(Windows):
    void GetRoundedRect(
        out D2D1_ROUNDED_RECT roundedRect 
        );
}


mixin(DX_DECLARE_IID("ID2D1EllipseGeometry", "2CD906A4-12E2-11DC-9FED-001143A055F9"));
interface ID2D1EllipseGeometry : ID2D1Geometry
{
extern(Windows):
    void GetEllipse(
        out D2D1_ELLIPSE ellipse 
        );
}


mixin(DX_DECLARE_IID("ID2D1GeometryGroup", "2CD906A6-12E2-11DC-9FED-001143A055F9"));
interface ID2D1GeometryGroup : ID2D1Geometry
{
extern(Windows):
    D2D1_FILL_MODE GetFillMode(
        );
    uint GetSourceGeometryCount(
        );
    void GetSourceGeometries(
        ID2D1Geometry* geometriesCArray,
        uint geometriesCount 
        );
}


mixin(DX_DECLARE_IID("ID2D1TransformedGeometry", "2CD906BB-12E2-11DC-9FED-001143A055F9"));
interface ID2D1TransformedGeometry : ID2D1Geometry
{
extern(Windows):
    void GetSourceGeometry(
        out ID2D1Geometry sourceGeometry 
        );
    void GetTransform(
        out D2D1_MATRIX_3X2_F transform 
        );
}


mixin(DX_DECLARE_IID("ID2D1SimplifiedGeometrySink", "2CD9069E-12E2-11DC-9FED-001143A055F9"));
interface ID2D1SimplifiedGeometrySink : IUnknown
{
extern(Windows):
    void SetFillMode(
        D2D1_FILL_MODE fillMode 
        );
    void SetSegmentFlags(
        D2D1_PATH_SEGMENT vertexFlags 
        );
    void BeginFigure(
        D2D1_POINT_2F startPoint,
        D2D1_FIGURE_BEGIN figureBegin 
        );
    void AddLines(
        in D2D1_POINT_2F* points,
        uint pointsCount 
        );
    void AddBeziers(
        in D2D1_BEZIER_SEGMENT* beziers,
        uint beziersCount 
        );
    void EndFigure(
        D2D1_FIGURE_END figureEnd 
        );
    HRESULT Close(
        );
}
alias ID2D1SimplifiedGeometrySink IDWriteGeometrySink;


mixin(DX_DECLARE_IID("ID2D1GeometrySink", "2CD9069F-12E2-11DC-9FED-001143A055F9"));
interface ID2D1GeometrySink : ID2D1SimplifiedGeometrySink
{
extern(Windows):
    void AddLine(
        D2D1_POINT_2F point 
        );
    void AddBezier(
        in D2D1_BEZIER_SEGMENT* bezier 
        );
    void AddQuadraticBezier(
        in D2D1_QUADRATIC_BEZIER_SEGMENT* bezier 
        );
    void AddQuadraticBeziers(
        in D2D1_QUADRATIC_BEZIER_SEGMENT* beziers,
        uint beziersCount 
        );
    void AddArc(
        in D2D1_ARC_SEGMENT arc 
        );
}


mixin(DX_DECLARE_IID("ID2D1TessellationSink", "2CD906C1-12E2-11DC-9FED-001143A055F9"));
interface ID2D1TessellationSink : IUnknown
{
extern(Windows):
    void AddTriangles(
        in D2D1_TRIANGLE* triangles,
        uint trianglesCount 
        );
    HRESULT Close(
        );
}


mixin(DX_DECLARE_IID("ID2D1PathGeometry", "2CD906A5-12E2-11DC-9FED-001143A055F9"));
interface ID2D1PathGeometry : ID2D1Geometry
{
extern(Windows):
    HRESULT Open(
        out ID2D1GeometrySink geometrySink 
        );
    HRESULT Stream(
        ID2D1GeometrySink geometrySink 
        );
    HRESULT GetSegmentCount(
        out uint count 
        );
    HRESULT GetFigureCount(
        out uint count 
        );
}


mixin(DX_DECLARE_IID("ID2D1Mesh", "2CD906C2-12E2-11DC-9FED-001143A055F9"));
interface ID2D1Mesh : ID2D1Resource
{
extern(Windows):
    HRESULT Open(
        out ID2D1TessellationSink tessellationSink 
        );
}


mixin(DX_DECLARE_IID("ID2D1Layer", "2CD9069B-12E2-11DC-9FED-001143A055F9"));
interface ID2D1Layer : ID2D1Resource
{
extern(Windows):
    D2D1_SIZE_F GetSize(
        );
}


mixin(DX_DECLARE_IID("ID2D1DrawingStateBlock", "28506E39-EBF6-46A1-BB47-FD85565AB957"));
interface ID2D1DrawingStateBlock : ID2D1Resource
{
extern(Windows):
    void GetDescription(
        out D2D1_DRAWING_STATE_DESCRIPTION stateDescription 
        );
    void SetDescription(
        in D2D1_DRAWING_STATE_DESCRIPTION* stateDescription 
        );
    void SetTextRenderingParams(
        /*optional*/ IDWriteRenderingParams textRenderingParams = null
        );
    void GetTextRenderingParams(
        out IDWriteRenderingParams textRenderingParams 
        );
}


mixin(DX_DECLARE_IID("ID2D1RenderTarget", "2CD90694-12E2-11DC-9FED-001143A055F9"));
interface ID2D1RenderTarget : ID2D1Resource
{
extern(Windows):
    HRESULT CreateBitmap(
        D2D1_SIZE_U size,
        in void* srcData,
        uint pitch,
        in D2D1_BITMAP_PROPERTIES* bitmapProperties,
        out ID2D1Bitmap bitmap 
        );
    HRESULT CreateBitmapFromWicBitmap(
        IWICBitmapSource wicBitmapSource,
        in D2D1_BITMAP_PROPERTIES* bitmapProperties,
        out ID2D1Bitmap bitmap 
        );
    HRESULT CreateSharedBitmap(
        in REFIID riid,
        void* data,
        in D2D1_BITMAP_PROPERTIES* bitmapProperties,
        out ID2D1Bitmap bitmap 
        );
    HRESULT CreateBitmapBrush(
        ID2D1Bitmap bitmap,
        in D2D1_BITMAP_BRUSH_PROPERTIES* bitmapBrushProperties,
        in D2D1_BRUSH_PROPERTIES* brushProperties,
        out ID2D1BitmapBrush bitmapBrush 
        );
    HRESULT CreateSolidColorBrush(
        in D2D1_COLOR_F* color,
        in D2D1_BRUSH_PROPERTIES* brushProperties,
        out ID2D1SolidColorBrush solidColorBrush 
        );
    HRESULT CreateGradientStopCollection(
        in D2D1_GRADIENT_STOP* gradientStops,
        uint gradientStopsCount,
        D2D1_GAMMA colorInterpolationGamma,
        D2D1_EXTEND_MODE extendMode,
        out ID2D1GradientStopCollection gradientStopCollection 
        );
    HRESULT CreateLinearGradientBrush(
        in D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES* linearGradientBrushProperties,
        in D2D1_BRUSH_PROPERTIES* brushProperties,
        ID2D1GradientStopCollection gradientStopCollection,
        out ID2D1LinearGradientBrush linearGradientBrush 
        );
    HRESULT CreateRadialGradientBrush(
        in D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES* radialGradientBrushProperties,
        in D2D1_BRUSH_PROPERTIES* brushProperties,
        ID2D1GradientStopCollection gradientStopCollection,
        out ID2D1RadialGradientBrush radialGradientBrush 
        );
    HRESULT CreateCompatibleRenderTarget(
        in D2D1_SIZE_F* desiredSize,
        in D2D1_SIZE_U* desiredPixelSize,
        in D2D1_PIXEL_FORMAT* desiredFormat,
        D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS options,
        out ID2D1BitmapRenderTarget bitmapRenderTarget 
        );
    HRESULT CreateLayer(
        in D2D1_SIZE_F* size,
        out ID2D1Layer layer 
        );
    HRESULT CreateMesh(
        out ID2D1Mesh mesh 
        );
    void DrawLine(
        D2D1_POINT_2F point0,
        D2D1_POINT_2F point1,
        ID2D1Brush brush,
        float strokeWidth = 1.0f,
        /*optional*/ ID2D1StrokeStyle strokeStyle = null
        );
    void DrawRectangle(
        in D2D1_RECT_F* rect,
        ID2D1Brush brush,
        float strokeWidth = 1.0f,
        /*optional*/ ID2D1StrokeStyle strokeStyle = null
        );
    void FillRectangle(
        in D2D1_RECT_F* rect,
        ID2D1Brush brush 
        );
    void DrawRoundedRectangle(
        in D2D1_ROUNDED_RECT* roundedRect,
        ID2D1Brush brush,
        float strokeWidth = 1.0f,
        /*optional*/ ID2D1StrokeStyle strokeStyle = null
        );
    void FillRoundedRectangle(
        in D2D1_ROUNDED_RECT* roundedRect,
        ID2D1Brush brush 
        );
    void DrawEllipse(
        in D2D1_ELLIPSE* ellipse,
        ID2D1Brush brush,
        float strokeWidth = 1.0f,
        /*optional*/ ID2D1StrokeStyle strokeStyle = null
        );
    void FillEllipse(
        in D2D1_ELLIPSE* ellipse,
        ID2D1Brush brush 
        );
    void DrawGeometry(
        ID2D1Geometry geometry,
        ID2D1Brush brush,
        float strokeWidth = 1.0f,
        /*optional*/ ID2D1StrokeStyle strokeStyle = null
        );
    void FillGeometry(
        ID2D1Geometry geometry,
        ID2D1Brush brush,
        /*optional*/ ID2D1Brush opacityBrush = null
        );
    void FillMesh(
        ID2D1Mesh mesh,
        ID2D1Brush brush 
        );
    void FillOpacityMask(
        ID2D1Bitmap opacityMask,
        ID2D1Brush brush,
        D2D1_OPACITY_MASK_CONTENT content,
        in D2D1_RECT_F* destinationRectangle = null,
        in D2D1_RECT_F* sourceRectangle = null 
        );
    void DrawBitmap(
        ID2D1Bitmap bitmap,
        in D2D1_RECT_F* destinationRectangle = null,
        float opacity = 1.0f,
        D2D1_BITMAP_INTERPOLATION_MODE interpolationMode = D2D1_BITMAP_INTERPOLATION_MODE.LINEAR,
        in D2D1_RECT_F* sourceRectangle = null 
        );
    void DrawText(
        in wchar* string,
        uint stringLength,
        IDWriteTextFormat textFormat,
        in D2D1_RECT_F* layoutRect,
        ID2D1Brush defaultForegroundBrush,
        D2D1_DRAW_TEXT_OPTIONS options = D2D1_DRAW_TEXT_OPTIONS.NONE,
        DWRITE_MEASURING_MODE measuringMode = DWRITE_MEASURING_MODE.NATURAL 
        );
    void DrawTextLayout(
        D2D1_POINT_2F origin,
        IDWriteTextLayout textLayout,
        ID2D1Brush defaultForegroundBrush,
        D2D1_DRAW_TEXT_OPTIONS options = D2D1_DRAW_TEXT_OPTIONS.NONE 
        );
    void DrawGlyphRun(
        D2D1_POINT_2F baselineOrigin,
        in DWRITE_GLYPH_RUN* glyphRun,
        ID2D1Brush foregroundBrush,
        DWRITE_MEASURING_MODE measuringMode = DWRITE_MEASURING_MODE.NATURAL 
        );
    void SetTransform(
        in D2D1_MATRIX_3X2_F* transform 
        );
    void GetTransform(
        out D2D1_MATRIX_3X2_F transform 
        );
    void SetAntialiasMode(
        D2D1_ANTIALIAS_MODE antialiasMode 
        );
    D2D1_ANTIALIAS_MODE GetAntialiasMode(
        );
    void SetTextAntialiasMode(
        D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode 
        );
    D2D1_TEXT_ANTIALIAS_MODE GetTextAntialiasMode(
        );
    void SetTextRenderingParams(
        /*optional*/ IDWriteRenderingParams textRenderingParams = null
        );
    void GetTextRenderingParams(
        out IDWriteRenderingParams textRenderingParams 
        );
    void SetTags(
        D2D1_TAG tag1,
        D2D1_TAG tag2 
        );
    void GetTags(
        D2D1_TAG* tag1 = null,
        D2D1_TAG* tag2 = null 
        );
    void PushLayer(
        in D2D1_LAYER_PARAMETERS* layerParameters,
        ID2D1Layer layer 
        );
    void PopLayer(
        );
    HRESULT Flush(
        D2D1_TAG* tag1 = null,
        D2D1_TAG* tag2 = null 
        );
    void SaveDrawingState(
        ID2D1DrawingStateBlock drawingStateBlock 
        );
    void RestoreDrawingState(
        ID2D1DrawingStateBlock drawingStateBlock 
        );
    void PushAxisAlignedClip(
        in D2D1_RECT_F* clipRect,
        D2D1_ANTIALIAS_MODE antialiasMode 
        );
    void PopAxisAlignedClip(
        );
    void Clear(
        in D2D1_COLOR_F* clearColor = null 
        );
    void BeginDraw(
        );
    HRESULT EndDraw(
        D2D1_TAG* tag1 = null,
        D2D1_TAG* tag2 = null 
        );
    D2D1_PIXEL_FORMAT GetPixelFormat(
        );
    void SetDpi(
        float dpiX,
        float dpiY 
        );
    void GetDpi(
        out float dpiX,
        out float dpiY 
        );
    D2D1_SIZE_F GetSize(
        );
    D2D1_SIZE_U GetPixelSize(
        );
    uint GetMaximumBitmapSize(
        );
    BOOL IsSupported(
        in D2D1_RENDER_TARGET_PROPERTIES* renderTargetProperties 
        );
}


mixin(DX_DECLARE_IID("ID2D1BitmapRenderTarget", "2CD90695-12E2-11DC-9FED-001143A055F9"));
interface ID2D1BitmapRenderTarget : ID2D1RenderTarget
{
extern(Windows):
    HRESULT GetBitmap(
        out ID2D1Bitmap bitmap 
        );
}


mixin(DX_DECLARE_IID("ID2D1HwndRenderTarget", "2CD90698-12E2-11DC-9FED-001143A055F9"));
interface ID2D1HwndRenderTarget : ID2D1RenderTarget
{
extern(Windows):
    D2D1_WINDOW_STATE CheckWindowState(
        );
    HRESULT Resize(
        in D2D1_SIZE_U* pixelSize 
        );
    HWND GetHwnd(
        );
}


mixin(DX_DECLARE_IID("ID2D1GdiInteropRenderTarget", "E0DB51C3-6F77-4BAE-B3D5-E47509B35838"));
interface ID2D1GdiInteropRenderTarget : IUnknown
{
extern(Windows):
    HRESULT GetDC(
        D2D1_DC_INITIALIZE_MODE mode,
        out HDC hdc 
        );
    HRESULT ReleaseDC(
        in RECT* update 
        );
}


mixin(DX_DECLARE_IID("ID2D1DCRenderTarget", "1C51BC64-DE61-46FD-9899-63A5D8F03950"));
interface ID2D1DCRenderTarget : ID2D1RenderTarget
{
extern(Windows):
    HRESULT BindDC(
        HDC hDC,
        in RECT* pSubRect 
        );
}


mixin(DX_DECLARE_IID("ID2D1Factory", "06152247-6F50-465A-9245-118BFD3B6007"));
interface ID2D1Factory : IUnknown
{
extern(Windows):
    HRESULT ReloadSystemMetrics(
        );
    void GetDesktopDpi(
        out float dpiX,
        out float dpiY 
        );
    HRESULT CreateRectangleGeometry(
        in D2D1_RECT_F* rectangle,
        out ID2D1RectangleGeometry rectangleGeometry 
        );
    HRESULT CreateRoundedRectangleGeometry(
        in D2D1_ROUNDED_RECT* roundedRectangle,
        out ID2D1RoundedRectangleGeometry roundedRectangleGeometry 
        );
    HRESULT CreateEllipseGeometry(
        in D2D1_ELLIPSE* ellipse,
        out ID2D1EllipseGeometry ellipseGeometry 
        );
    HRESULT CreateGeometryGroup(
        D2D1_FILL_MODE fillMode,
        ID2D1Geometry* geometriesCArray,
        uint geometriesCount,
        out ID2D1GeometryGroup geometryGroup 
        );
    HRESULT CreateTransformedGeometry(
        ID2D1Geometry sourceGeometry,
        in D2D1_MATRIX_3X2_F* transform,
        out ID2D1TransformedGeometry transformedGeometry 
        );
    HRESULT CreatePathGeometry(
        out ID2D1PathGeometry pathGeometry 
        );
    HRESULT CreateStrokeStyle(
        in D2D1_STROKE_STYLE_PROPERTIES* strokeStyleProperties,
        in float* dashes,
        uint dashesCount,
        out ID2D1StrokeStyle strokeStyle 
        );
    HRESULT CreateDrawingStateBlock(
        in D2D1_DRAWING_STATE_DESCRIPTION* drawingStateDescription,
        IDWriteRenderingParams textRenderingParams,
        out ID2D1DrawingStateBlock drawingStateBlock 
        );
    HRESULT CreateWicBitmapRenderTarget(
        IWICBitmap target,
        in D2D1_RENDER_TARGET_PROPERTIES* renderTargetProperties,
        out ID2D1RenderTarget renderTarget 
        );
    HRESULT CreateHwndRenderTarget(
        in D2D1_RENDER_TARGET_PROPERTIES* renderTargetProperties,
        in D2D1_HWND_RENDER_TARGET_PROPERTIES* hwndRenderTargetProperties,
        out ID2D1HwndRenderTarget hwndRenderTarget 
        );
    HRESULT CreateDxgiSurfaceRenderTarget(
        IDXGISurface dxgiSurface,
        in D2D1_RENDER_TARGET_PROPERTIES* renderTargetProperties,
        out ID2D1RenderTarget renderTarget 
        );
    HRESULT CreateDCRenderTarget(
        in D2D1_RENDER_TARGET_PROPERTIES* renderTargetProperties,
        out ID2D1DCRenderTarget dcRenderTarget 
        );
}


extern(Windows)
{
HRESULT D2D1CreateFactory(
    D2D1_FACTORY_TYPE factoryType,
    REFIID riid,
    in D2D1_FACTORY_OPTIONS* pFactoryOptions,
    out void* ppIFactory
    );
void D2D1MakeRotateMatrix(
    float angle,
    D2D1_POINT_2F center,
    out D2D1_MATRIX_3X2_F matrix
    );
void D2D1MakeSkewMatrix(
    float angleX,
    float angleY,
    D2D1_POINT_2F center,
    out D2D1_MATRIX_3X2_F matrix
    );
BOOL D2D1IsMatrixInvertible(
    in D2D1_MATRIX_3X2_F* matrix
    );
BOOL D2D1InvertMatrix(
    ref D2D1_MATRIX_3X2_F matrix
    );
}
