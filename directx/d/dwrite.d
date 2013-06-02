// D Bindings for DirectWrite
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.dwrite;


import win32.directx.dxinternal;
import win32.directx.d2d1;
import win32.windows;
import std.bitmanip;
import std.c.windows.com;


alias std.c.windows.com.IUnknown IUnknown;
alias std.c.windows.com.GUID GUID;
alias std.c.windows.com.IID IID;


// dwrite has indirect dependencies on the d3d and dxgi base types and values
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
static assert(DWRITE_MEASURING_MODE.sizeof == 4);
static assert(DWRITE_FONT_FILE_TYPE.sizeof == 4);
static assert(DWRITE_FONT_FACE_TYPE.sizeof == 4);
static assert(DWRITE_FONT_SIMULATIONS.sizeof == 4);
static assert(DWRITE_FONT_WEIGHT.sizeof == 4);
static assert(DWRITE_FONT_STRETCH.sizeof == 4);
static assert(DWRITE_FONT_STYLE.sizeof == 4);
static assert(DWRITE_INFORMATIONAL_STRING_ID.sizeof == 4);
static assert(DWRITE_FACTORY_TYPE.sizeof == 4);
static assert(DWRITE_PIXEL_GEOMETRY.sizeof == 4);
static assert(DWRITE_RENDERING_MODE.sizeof == 4);
static assert(DWRITE_READING_DIRECTION.sizeof == 4);
static assert(DWRITE_FLOW_DIRECTION.sizeof == 4);
static assert(DWRITE_TEXT_ALIGNMENT.sizeof == 4);
static assert(DWRITE_PARAGRAPH_ALIGNMENT.sizeof == 4);
static assert(DWRITE_WORD_WRAPPING.sizeof == 4);
static assert(DWRITE_LINE_SPACING_METHOD.sizeof == 4);
static assert(DWRITE_TRIMMING_GRANULARITY.sizeof == 4);
static assert(DWRITE_FONT_FEATURE_TAG.sizeof == 4);
static assert(DWRITE_SCRIPT_SHAPES.sizeof == 4);
static assert(DWRITE_BREAK_CONDITION.sizeof == 4);
static assert(DWRITE_NUMBER_SUBSTITUTION_METHOD.sizeof == 4);
static assert(DWRITE_TEXTURE_TYPE.sizeof == 4);

// Structs
version(X86)
{
static assert(DWRITE_SCRIPT_ANALYSIS.sizeof == 8);
static assert(DWRITE_FONT_METRICS.sizeof == 20);
static assert(DWRITE_GLYPH_METRICS.sizeof == 28);
static assert(DWRITE_GLYPH_OFFSET.sizeof == 8);
static assert(DWRITE_MATRIX.sizeof == 24);
static assert(DWRITE_TEXT_RANGE.sizeof == 8);
static assert(DWRITE_FONT_FEATURE.sizeof == 8);
static assert(DWRITE_TYPOGRAPHIC_FEATURES.sizeof == 8);
static assert(DWRITE_TRIMMING.sizeof == 12);
static assert(DWRITE_LINE_BREAKPOINT.sizeof == 1);
static assert(DWRITE_SHAPING_TEXT_PROPERTIES.sizeof == 2);
static assert(DWRITE_SHAPING_GLYPH_PROPERTIES.sizeof == 2);
static assert(DWRITE_GLYPH_RUN.sizeof == 32);
static assert(DWRITE_GLYPH_RUN_DESCRIPTION.sizeof == 20);
static assert(DWRITE_UNDERLINE.sizeof == 32);
static assert(DWRITE_STRIKETHROUGH.sizeof == 28);
static assert(DWRITE_LINE_METRICS.sizeof == 24);
static assert(DWRITE_CLUSTER_METRICS.sizeof == 8);
static assert(DWRITE_TEXT_METRICS.sizeof == 36);
static assert(DWRITE_INLINE_OBJECT_METRICS.sizeof == 16);
static assert(DWRITE_OVERHANG_METRICS.sizeof == 16);
static assert(DWRITE_HIT_TEST_METRICS.sizeof == 36);
}
version(X86_64)
{
static assert(DWRITE_SCRIPT_ANALYSIS.sizeof == 8);
static assert(DWRITE_FONT_METRICS.sizeof == 20);
static assert(DWRITE_GLYPH_METRICS.sizeof == 28);
static assert(DWRITE_GLYPH_OFFSET.sizeof == 8);
static assert(DWRITE_MATRIX.sizeof == 24);
static assert(DWRITE_TEXT_RANGE.sizeof == 8);
static assert(DWRITE_FONT_FEATURE.sizeof == 8);
static assert(DWRITE_TYPOGRAPHIC_FEATURES.sizeof == 16);
static assert(DWRITE_TRIMMING.sizeof == 12);
static assert(DWRITE_LINE_BREAKPOINT.sizeof == 1);
static assert(DWRITE_SHAPING_TEXT_PROPERTIES.sizeof == 2);
static assert(DWRITE_SHAPING_GLYPH_PROPERTIES.sizeof == 2);
static assert(DWRITE_GLYPH_RUN.sizeof == 48);
static assert(DWRITE_GLYPH_RUN_DESCRIPTION.sizeof == 40);
static assert(DWRITE_UNDERLINE.sizeof == 40);
static assert(DWRITE_STRIKETHROUGH.sizeof == 40);
static assert(DWRITE_LINE_METRICS.sizeof == 24);
static assert(DWRITE_CLUSTER_METRICS.sizeof == 8);
static assert(DWRITE_TEXT_METRICS.sizeof == 36);
static assert(DWRITE_INLINE_OBJECT_METRICS.sizeof == 16);
static assert(DWRITE_OVERHANG_METRICS.sizeof == 16);
static assert(DWRITE_HIT_TEST_METRICS.sizeof == 36);
}


/////////////////////////
// DWrite Enums


// Macros used to define DirectWrite error codes.
enum FACILITY_DWRITE = 0x898;
enum DWRITE_ERR_BASE = 0x5000;


template DWRITE_MAKE_OPENTYPE_TAG()
{
    uint DWRITE_MAKE_OPENTYPE_TAG(ubyte a, ubyte b, ubyte c, ubyte d)
    {
        return (
            ((cast(uint)d) << 24) |
            ((cast(uint)c) << 16) |
            ((cast(uint)b) << 8)  |
             cast(uint)a);
    }
}


template MAKE_HRESULT()
{
    HRESULT MAKE_HRESULT(uint sev, uint fac, uint code)
    {
        return cast(HRESULT)(((sev)<<31) | ((fac)<<16) | ((code)));
    }
}


template MAKE_DWRITE_HR()
{
    HRESULT MAKE_DWRITE_HR(uint severity, uint code)
    {
        return MAKE_HRESULT(severity, FACILITY_DWRITE, (DWRITE_ERR_BASE + code));
    }
}


template MAKE_DWRITE_HR_ERR()
{
    HRESULT MAKE_DWRITE_HR_ERR(uint code)
    {
        return MAKE_DWRITE_HR(SEVERITY_ERROR, code);
    }
}


enum DWRITE_E_FILEFORMAT             = MAKE_DWRITE_HR_ERR(0x000);
enum DWRITE_E_UNEXPECTED             = MAKE_DWRITE_HR_ERR(0x001);
enum DWRITE_E_NOFONT                 = MAKE_DWRITE_HR_ERR(0x002);
enum DWRITE_E_FILENOTFOUND           = MAKE_DWRITE_HR_ERR(0x003);
enum DWRITE_E_FILEACCESS             = MAKE_DWRITE_HR_ERR(0x004);
enum DWRITE_E_FONTCOLLECTIONOBSOLETE = MAKE_DWRITE_HR_ERR(0x005);
enum DWRITE_E_ALREADYREGISTERED      = MAKE_DWRITE_HR_ERR(0x006);


enum DWRITE_MEASURING_MODE : uint
{
    NATURAL,
    GDI_CLASSIC,
    GDI_NATURAL
}


enum DWRITE_FONT_FILE_TYPE : uint
{
    UNKNOWN,
    CFF,
    TRUETYPE,
    TRUETYPE_COLLECTION,
    TYPE1_PFM,
    TYPE1_PFB,
    VECTOR,
    BITMAP
}


enum DWRITE_FONT_FACE_TYPE : uint
{
    CFF,
    TRUETYPE,
    TRUETYPE_COLLECTION,
    TYPE1,
    VECTOR,
    BITMAP,
    UNKNOWN
}


enum DWRITE_FONT_SIMULATIONS : uint
{
    NONE    = 0x0000,
    BOLD    = 0x0001,
    OBLIQUE = 0x0002
}


enum DWRITE_FONT_WEIGHT : uint
{
    THIN = 100,
    EXTRA_LIGHT = 200,
    ULTRA_LIGHT = 200,
    LIGHT = 300,
    NORMAL = 400,
    REGULAR = 400,
    MEDIUM = 500,
    DEMI_BOLD = 600,
    SEMI_BOLD = 600,
    BOLD = 700,
    EXTRA_BOLD = 800,
    ULTRA_BOLD = 800,
    BLACK = 900,
    HEAVY = 900,
    EXTRA_BLACK = 950,
    ULTRA_BLACK = 950
}


enum DWRITE_FONT_STRETCH : uint
{
    UNDEFINED = 0,
    ULTRA_CONDENSED = 1,
    EXTRA_CONDENSED = 2,
    CONDENSED = 3,
    SEMI_CONDENSED = 4,
    NORMAL = 5,
    MEDIUM = 5,
    SEMI_EXPANDED = 6,
    EXPANDED = 7,
    EXTRA_EXPANDED = 8,
    ULTRA_EXPANDED = 9
}


enum DWRITE_FONT_STYLE : uint
{
    NORMAL,
    OBLIQUE,
    ITALIC
}


enum DWRITE_INFORMATIONAL_STRING_ID : uint
{
    NONE,
    COPYRIGHT_NOTICE,
    VERSION_STRINGS,
    TRADEMARK,
    MANUFACTURER,
    DESIGNER,
    DESIGNER_URL,
    DESCRIPTION,
    FONT_VENDOR_URL,
    LICENSE_DESCRIPTION,
    LICENSE_INFO_URL,
    WIN32_FAMILY_NAMES,
    WIN32_SUBFAMILY_NAMES,
    PREFERRED_FAMILY_NAMES,
    PREFERRED_SUBFAMILY_NAMES,
    SAMPLE_TEXT
}


enum DWRITE_FACTORY_TYPE : uint
{
    SHARED,
    ISOLATED
}


enum DWRITE_PIXEL_GEOMETRY : uint
{
    FLAT,
    RGB,
    BGR
}


enum DWRITE_RENDERING_MODE : uint
{
    DEFAULT,
    ALIASED,
    CLEARTYPE_GDI_CLASSIC,
    CLEARTYPE_GDI_NATURAL,
    CLEARTYPE_NATURAL,
    CLEARTYPE_NATURAL_SYMMETRIC,
    OUTLINE
}


enum DWRITE_READING_DIRECTION : uint
{
    LEFT_TO_RIGHT,
    RIGHT_TO_LEFT
}


enum DWRITE_FLOW_DIRECTION : uint
{
    TOP_TO_BOTTOM
}


enum DWRITE_TEXT_ALIGNMENT : uint
{
    LEADING,
    TRAILING,
    CENTER
}


enum DWRITE_PARAGRAPH_ALIGNMENT : uint
{
    NEAR,
    FAR,
    CENTER
}


enum DWRITE_WORD_WRAPPING : uint
{
    WRAP,
    NO_WRAP
}


enum DWRITE_LINE_SPACING_METHOD : uint
{
    DEFAULT,
    UNIFORM
}


enum DWRITE_TRIMMING_GRANULARITY : uint
{
    NONE,
    CHARACTER,
    WORD	
}


enum DWRITE_FONT_FEATURE_TAG : uint
{
    ALTERNATIVE_FRACTIONS               = 0x63726661, // 'afrc'
    PETITE_CAPITALS_FROM_CAPITALS       = 0x63703263, // 'c2pc'
    SMALL_CAPITALS_FROM_CAPITALS        = 0x63733263, // 'c2sc'
    CONTEXTUAL_ALTERNATES               = 0x746c6163, // 'calt'
    CASE_SENSITIVE_FORMS                = 0x65736163, // 'case'
    GLYPH_COMPOSITION_DECOMPOSITION     = 0x706d6363, // 'ccmp'
    CONTEXTUAL_LIGATURES                = 0x67696c63, // 'clig'
    CAPITAL_SPACING                     = 0x70737063, // 'cpsp'
    CONTEXTUAL_SWASH                    = 0x68777363, // 'cswh'
    CURSIVE_POSITIONING                 = 0x73727563, // 'curs'
    DEFAULT                             = 0x746c6664, // 'dflt'
    DISCRETIONARY_LIGATURES             = 0x67696c64, // 'dlig'
    EXPERT_FORMS                        = 0x74707865, // 'expt'
    FRACTIONS                           = 0x63617266, // 'frac'
    FULL_WIDTH                          = 0x64697766, // 'fwid'
    HALF_FORMS                          = 0x666c6168, // 'half'
    HALANT_FORMS                        = 0x6e6c6168, // 'haln'
    ALTERNATE_HALF_WIDTH                = 0x746c6168, // 'halt'
    HISTORICAL_FORMS                    = 0x74736968, // 'hist'
    HORIZONTAL_KANA_ALTERNATES          = 0x616e6b68, // 'hkna'
    HISTORICAL_LIGATURES                = 0x67696c68, // 'hlig'
    HALF_WIDTH                          = 0x64697768, // 'hwid'
    HOJO_KANJI_FORMS                    = 0x6f6a6f68, // 'hojo'
    JIS04_FORMS                         = 0x3430706a, // 'jp04'
    JIS78_FORMS                         = 0x3837706a, // 'jp78'
    JIS83_FORMS                         = 0x3338706a, // 'jp83'
    JIS90_FORMS                         = 0x3039706a, // 'jp90'
    KERNING                             = 0x6e72656b, // 'kern'
    STANDARD_LIGATURES                  = 0x6167696c, // 'liga'
    LINING_FIGURES                      = 0x6d756e6c, // 'lnum'
    LOCALIZED_FORMS                     = 0x6c636f6c, // 'locl'
    MARK_POSITIONING                    = 0x6b72616d, // 'mark'
    MATHEMATICAL_GREEK                  = 0x6b72676d, // 'mgrk'
    MARK_TO_MARK_POSITIONING            = 0x6b6d6b6d, // 'mkmk'
    ALTERNATE_ANNOTATION_FORMS          = 0x746c616e, // 'nalt'
    NLC_KANJI_FORMS                     = 0x6b636c6e, // 'nlck'
    OLD_STYLE_FIGURES                   = 0x6d756e6f, // 'onum'
    ORDINALS                            = 0x6e64726f, // 'ordn'
    PROPORTIONAL_ALTERNATE_WIDTH        = 0x746c6170, // 'palt'
    PETITE_CAPITALS                     = 0x70616370, // 'pcap'
    PROPORTIONAL_FIGURES                = 0x6d756e70, // 'pnum'
    PROPORTIONAL_WIDTHS                 = 0x64697770, // 'pwid'
    QUARTER_WIDTHS                      = 0x64697771, // 'qwid'
    REQUIRED_LIGATURES                  = 0x67696c72, // 'rlig'
    RUBY_NOTATION_FORMS                 = 0x79627572, // 'ruby'
    STYLISTIC_ALTERNATES                = 0x746c6173, // 'salt'
    SCIENTIFIC_INFERIORS                = 0x666e6973, // 'sinf'
    SMALL_CAPITALS                      = 0x70636d73, // 'smcp'
    SIMPLIFIED_FORMS                    = 0x6c706d73, // 'smpl'
    STYLISTIC_SET_1                     = 0x31307373, // 'ss01'
    STYLISTIC_SET_2                     = 0x32307373, // 'ss02'
    STYLISTIC_SET_3                     = 0x33307373, // 'ss03'
    STYLISTIC_SET_4                     = 0x34307373, // 'ss04'
    STYLISTIC_SET_5                     = 0x35307373, // 'ss05'
    STYLISTIC_SET_6                     = 0x36307373, // 'ss06'
    STYLISTIC_SET_7                     = 0x37307373, // 'ss07'
    STYLISTIC_SET_8                     = 0x38307373, // 'ss08'
    STYLISTIC_SET_9                     = 0x39307373, // 'ss09'
    STYLISTIC_SET_10                    = 0x30317373, // 'ss10'
    STYLISTIC_SET_11                    = 0x31317373, // 'ss11'
    STYLISTIC_SET_12                    = 0x32317373, // 'ss12'
    STYLISTIC_SET_13                    = 0x33317373, // 'ss13'
    STYLISTIC_SET_14                    = 0x34317373, // 'ss14'
    STYLISTIC_SET_15                    = 0x35317373, // 'ss15'
    STYLISTIC_SET_16                    = 0x36317373, // 'ss16'
    STYLISTIC_SET_17                    = 0x37317373, // 'ss17'
    STYLISTIC_SET_18                    = 0x38317373, // 'ss18'
    STYLISTIC_SET_19                    = 0x39317373, // 'ss19'
    STYLISTIC_SET_20                    = 0x30327373, // 'ss20'
    SUBSCRIPT                           = 0x73627573, // 'subs'
    SUPERSCRIPT                         = 0x73707573, // 'sups'
    SWASH                               = 0x68737773, // 'swsh'
    TITLING                             = 0x6c746974, // 'titl'
    TRADITIONAL_NAME_FORMS              = 0x6d616e74, // 'tnam'
    TABULAR_FIGURES                     = 0x6d756e74, // 'tnum'
    TRADITIONAL_FORMS                   = 0x64617274, // 'trad'
    THIRD_WIDTHS                        = 0x64697774, // 'twid'
    UNICASE                             = 0x63696e75, // 'unic'
    SLASHED_ZERO                        = 0x6f72657a, // 'zero'
}


enum DWRITE_SCRIPT_SHAPES : uint
{
   DEFAULT = 0,
   NO_VISUAL = 1
}


enum DWRITE_BREAK_CONDITION : uint
{
    NEUTRAL,
    CAN_BREAK,
    MAY_NOT_BREAK,
    MUST_BREAK
}


enum DWRITE_NUMBER_SUBSTITUTION_METHOD : uint
{
    FROM_CULTURE,
    CONTEXTUAL,
    NONE,
    NATIONAL,
    TRADITIONAL
}


enum DWRITE_TEXTURE_TYPE : uint
{
    ALIASED_1x1,
    CLEARTYPE_3x1
}
alias DWRITE_TEXTURE_TYPE DWRITE_TEXTURE;


enum DWRITE_ALPHA_MAX = 255;


/////////////////////////
// DWrite Structs


struct DWRITE_SCRIPT_ANALYSIS
{
    ushort script;
    DWRITE_SCRIPT_SHAPES shapes;
}


struct DWRITE_FONT_METRICS
{
    ushort designUnitsPerEm;
    ushort ascent;
    ushort descent;
    short lineGap;
    ushort capHeight;
    ushort xHeight;
    short underlinePosition;
    ushort underlineThickness;
    short strikethroughPosition;
    ushort strikethroughThickness;
}


struct DWRITE_GLYPH_METRICS
{
    int leftSideBearing;
    uint advanceWidth;
    int rightSideBearing;
    int topSideBearing;
    uint advanceHeight;
    int bottomSideBearing;
    int verticalOriginY;
}


struct DWRITE_GLYPH_OFFSET
{
    float advanceOffset;
    float ascenderOffset;
}


struct DWRITE_MATRIX
{
    float m11;
    float m12;
    float m21;
    float m22;
    float dx;
    float dy;
}


struct DWRITE_TEXT_RANGE
{
    uint startPosition;
    uint length;
}


struct DWRITE_FONT_FEATURE
{
    DWRITE_FONT_FEATURE_TAG nameTag;
    uint parameter;
}


struct DWRITE_TYPOGRAPHIC_FEATURES
{
    DWRITE_FONT_FEATURE* features;
    uint featureCount;
}


struct DWRITE_TRIMMING
{
    DWRITE_TRIMMING_GRANULARITY granularity;
    uint delimiter;
    uint delimiterCount;
}


struct DWRITE_LINE_BREAKPOINT
{
    mixin(bitfields!(
                     ubyte, "breakConditionBefore", 2,
                     ubyte, "breakConditionAfter", 2,
                     ubyte, "isWhitespace", 1,
                     ubyte, "isSoftHyphen", 1,
                     ubyte, "padding", 2));
}
static assert(DWRITE_LINE_BREAKPOINT.sizeof == 1);


struct DWRITE_SHAPING_TEXT_PROPERTIES
{
    mixin(bitfields!(
                     ushort, "isShapedAlone", 1,
                     ushort, "reserved", 15));
}
static assert(DWRITE_SHAPING_TEXT_PROPERTIES.sizeof == 2);


struct DWRITE_SHAPING_GLYPH_PROPERTIES
{
    mixin(bitfields!(
                     ushort, "justification", 4,
                     ushort, "isClusterStart", 1,
                     ushort, "isDiacritic", 1,
                     ushort, "isZeroWidthSpace", 1,
                     ushort, "reserved", 9));
}
static assert(DWRITE_SHAPING_GLYPH_PROPERTIES.sizeof == 2);


struct DWRITE_GLYPH_RUN
{
    IDWriteFontFace fontFace;
    float fontEmSize;
    uint glyphCount;
    ushort* glyphIndices;
    float* glyphAdvances;
    DWRITE_GLYPH_OFFSET* glyphOffsets;
    BOOL isSideways;
    uint bidiLevel;
}


struct DWRITE_GLYPH_RUN_DESCRIPTION
{
    WCHAR* localeName;
    WCHAR* string;
    uint stringLength;
    ushort* clusterMap;
    uint textPosition;
}


struct DWRITE_UNDERLINE
{
    float width;
    float thickness;
    float offset;
    float runHeight;
    DWRITE_READING_DIRECTION readingDirection;
    DWRITE_FLOW_DIRECTION flowDirection;
    WCHAR* localeName;
    DWRITE_MEASURING_MODE measuringMode;
}


struct DWRITE_STRIKETHROUGH
{
    float width;
    float thickness;
    float offset;
    DWRITE_READING_DIRECTION readingDirection;
    DWRITE_FLOW_DIRECTION flowDirection;
    WCHAR* localeName;
    DWRITE_MEASURING_MODE measuringMode;
}


struct DWRITE_LINE_METRICS
{
    uint length;
    uint trailingWhitespaceLength;
    uint newlineLength;
    float height;
    float baseline;
    BOOL isTrimmed;
}


struct DWRITE_CLUSTER_METRICS
{
    float width;
    ushort length;
    mixin(bitfields!(
                     ushort, "canWrapLineAfter", 1,
                     ushort, "isWhitespace", 1,
                     ushort, "isNewline", 1,
                     ushort, "isSoftHyphen", 1,
                     ushort, "isRightToLeft", 1,
                     ushort, "padding", 11,));
}


struct DWRITE_TEXT_METRICS
{
    float left;
    float top;
    float width;
    float widthIncludingTrailingWhitespace;
    float height;
    float layoutWidth;
    float layoutHeight;
    uint maxBidiReorderingDepth;
    uint lineCount;
}


struct DWRITE_INLINE_OBJECT_METRICS
{
    float width;
    float height;
    float baseline;
    BOOL  supportsSideways;
}


struct DWRITE_OVERHANG_METRICS
{
    float left;
    float top;
    float right;
    float bottom;
}


struct DWRITE_HIT_TEST_METRICS
{
    uint textPosition;
    uint length;
    float left;
    float top;
    float width;
    float height;
    uint bidiLevel;
    BOOL isText;
    BOOL isTrimmed;
}


/////////////////////////
// DWrite Interfaces


mixin(DX_DECLARE_IID("IDWriteFontFileLoader", "727CAD4E-D6AF-4C9E-8A08-D695B11CAA49"));
interface IDWriteFontFileLoader : IUnknown
{
extern(Windows):
    HRESULT CreateStreamFromKey(
        in void* fontFileReferenceKey,
        uint fontFileReferenceKeySize,
        out IDWriteFontFileStream fontFileStream
        );
}


mixin(DX_DECLARE_IID("IDWriteLocalFontFileLoader", "B2D9F3EC-C9FE-4A11-A2EC-D86208F7C0A2"));
interface IDWriteLocalFontFileLoader : IDWriteFontFileLoader
{
extern(Windows):
    HRESULT GetFilePathLengthFromKey(
        in void* fontFileReferenceKey,
        uint fontFileReferenceKeySize,
        out uint filePathLength
        );
    HRESULT GetFilePathFromKey(
        in void* fontFileReferenceKey,
        uint fontFileReferenceKeySize,
        WCHAR* filePath,
        uint filePathSize
        );
    HRESULT GetLastWriteTimeFromKey(
        in void* fontFileReferenceKey,
        uint fontFileReferenceKeySize,
        out FILETIME lastWriteTime
        );
}


mixin(DX_DECLARE_IID("IDWriteFontFileStream", "6D4865FE-0AB8-4D91-8F62-5DD6BE34A3E0"));
interface IDWriteFontFileStream : IUnknown
{
extern(Windows):
    HRESULT ReadFileFragment(
        void** fragmentStart,
        ulong fileOffset,
        ulong fragmentSize,
        out void* fragmentContext
        );
    void ReleaseFileFragment(
        void* fragmentContext
        );
    HRESULT GetFileSize(
        out ulong fileSize
        );
    HRESULT GetLastWriteTime(
        out ulong lastWriteTime
        );
}


mixin(DX_DECLARE_IID("IDWriteFontFile", "739D886A-CEF5-47DC-8769-1A8B41BEBBB0"));
interface IDWriteFontFile : IUnknown
{
extern(Windows):
    HRESULT GetReferenceKey(
        void** fontFileReferenceKey,
        out uint fontFileReferenceKeySize
        );
    HRESULT GetLoader(
        out IDWriteFontFileLoader fontFileLoader
        );
    HRESULT Analyze(
        out BOOL isSupportedFontType,
        out DWRITE_FONT_FILE_TYPE fontFileType,
        DWRITE_FONT_FACE_TYPE* fontFaceType,
        out uint numberOfFaces
        );
}


mixin(DX_DECLARE_IID("IDWriteRenderingParams", "2F0DA53A-2ADD-47CD-82EE-D9EC34688E75"));
interface IDWriteRenderingParams : IUnknown
{
extern(Windows):
    float GetGamma(
        );
    float GetEnhancedContrast(
        );
    float GetClearTypeLevel(
        );
    DWRITE_PIXEL_GEOMETRY GetPixelGeometry(
        );
    DWRITE_RENDERING_MODE GetRenderingMode(
        );
}


mixin(DX_DECLARE_IID("IDWriteFontFace", "5F49804D-7024-4D43-BFA9-D25984F53849"));
interface IDWriteFontFace : IUnknown
{
extern(Windows):
    DWRITE_FONT_FACE_TYPE GetType(
        );
    HRESULT GetFiles(
        ref uint numberOfFiles,
        IDWriteFontFile* fontFiles
        );
    uint GetIndex(
        );
    DWRITE_FONT_SIMULATIONS GetSimulations(
        );
    BOOL IsSymbolFont(
        );
    void GetMetrics(
        out DWRITE_FONT_METRICS fontFaceMetrics
        );
    ushort GetGlyphCount(
        );
    HRESULT GetDesignGlyphMetrics(
        in ushort* glyphIndices,
        uint glyphCount,
        DWRITE_GLYPH_METRICS* glyphMetrics,
        BOOL isSideways = FALSE
        );
    HRESULT GetGlyphIndices(
        in uint* codePoints,
        uint codePointCount,
        ushort* glyphIndices
        );
    HRESULT TryGetFontTable(
        uint openTypeTableTag,
        in void** tableData,
        out uint tableSize,
        out void* tableContext,
        out BOOL exists
        );
    void ReleaseFontTable(
        void* tableContext
        );
    HRESULT GetGlyphRunOutline(
        float emSize,
        in ushort* glyphIndices,
        in float* glyphAdvances,
        in DWRITE_GLYPH_OFFSET* glyphOffsets,
        uint glyphCount,
        BOOL isSideways,
        BOOL isRightToLeft,
        IDWriteGeometrySink geometrySink
        );
    HRESULT GetRecommendedRenderingMode(
        float emSize,
        float pixelsPerDip,
        DWRITE_MEASURING_MODE measuringMode,
        IDWriteRenderingParams renderingParams,
        out DWRITE_RENDERING_MODE renderingMode
        );
    HRESULT GetGdiCompatibleMetrics(
        float emSize,
        float pixelsPerDip,
        in DWRITE_MATRIX* transform,
        out DWRITE_FONT_METRICS fontFaceMetrics
        );
    HRESULT GetGdiCompatibleGlyphMetrics(
        float emSize,
        float pixelsPerDip,
        in DWRITE_MATRIX* transform,
        BOOL useGdiNatural,
        in ushort* glyphIndices,
        uint glyphCount,
        DWRITE_GLYPH_METRICS* glyphMetrics,
        BOOL isSideways = FALSE
        );
}


mixin(DX_DECLARE_IID("IDWriteFontCollectionLoader", "CCA920E4-52F0-492B-BFA8-29C72EE0A468"));
interface IDWriteFontCollectionLoader : IUnknown
{
extern(Windows):
    HRESULT CreateEnumeratorFromKey(
        IDWriteFactory factory,
        in void* collectionKey,
        uint collectionKeySize,
        out IDWriteFontFileEnumerator fontFileEnumerator
        );
}


mixin(DX_DECLARE_IID("IDWriteFontFileEnumerator", "72755049-5FF7-435D-8348-4BE97CFA6C7C"));
interface IDWriteFontFileEnumerator : IUnknown
{
extern(Windows):
    HRESULT MoveNext(
        out BOOL hasCurrentFile
        );
    HRESULT GetCurrentFontFile(
        out IDWriteFontFile fontFile
        );
}


mixin(DX_DECLARE_IID("IDWriteLocalizedStrings", "08256209-099A-4B34-B86D-C22B110E7771"));
interface IDWriteLocalizedStrings : IUnknown
{
extern(Windows):
    uint GetCount(
        );
    HRESULT FindLocaleName(
        in WCHAR* localeName, 
        out uint index,
        out BOOL exists
        );
    HRESULT GetLocaleNameLength(
        uint index,
        out uint length
        );
    HRESULT GetLocaleName(
        uint index,
        WCHAR* localeName,
        uint size
        );
    HRESULT GetStringLength(
        uint index,
        out uint length
        );
    HRESULT GetString(
        uint index,
        WCHAR* stringBuffer,
        uint size
        );
}


mixin(DX_DECLARE_IID("IDWriteFontCollection", "A84CEE02-3EEA-4EEE-A827-87C1A02A0FCC"));
interface IDWriteFontCollection : IUnknown
{
extern(Windows):
    uint GetFontFamilyCount(
        );
    HRESULT GetFontFamily(
        uint index,
        out IDWriteFontFamily fontFamily
        );
    HRESULT FindFamilyName(
        in WCHAR* familyName,
        out uint index,
        out BOOL exists
        );
    HRESULT GetFontFromFontFace(
        IDWriteFontFace fontFace,
        out IDWriteFont font
        );
}


mixin(DX_DECLARE_IID("IDWriteFontList", "1A0D8438-1D97-4EC1-AEF9-A2FB86ED6ACB"));
interface IDWriteFontList : IUnknown
{
extern(Windows):
    HRESULT GetFontCollection(
        out IDWriteFontCollection fontCollection
        );
    uint GetFontCount(
        );
    HRESULT GetFont(
        uint index, 
        out IDWriteFont font
        );
}


mixin(DX_DECLARE_IID("IDWriteFontFamily", "DA20D8EF-812A-4C43-9802-62EC4ABD7ADD"));
interface IDWriteFontFamily : IDWriteFontList
{
extern(Windows):
    HRESULT GetFamilyNames(
        out IDWriteLocalizedStrings names
        );
    HRESULT GetFirstMatchingFont(
        DWRITE_FONT_WEIGHT  weight,
        DWRITE_FONT_STRETCH stretch,
        DWRITE_FONT_STYLE   style,
        out IDWriteFont matchingFont
        );
    HRESULT GetMatchingFonts(
        DWRITE_FONT_WEIGHT      weight,
        DWRITE_FONT_STRETCH     stretch,
        DWRITE_FONT_STYLE       style,
        out IDWriteFontList matchingFonts
        );
}


mixin(DX_DECLARE_IID("IDWriteFont", "ACD16696-8C14-4F5D-877E-FE3FC1D32737"));
interface IDWriteFont : IUnknown
{
extern(Windows):
    HRESULT GetFontFamily(
        out IDWriteFontFamily fontFamily
        );
    DWRITE_FONT_WEIGHT GetWeight(
        );
    DWRITE_FONT_STRETCH GetStretch(
        );
    DWRITE_FONT_STYLE GetStyle(
        );
    BOOL IsSymbolFont(
        );
    HRESULT GetFaceNames(
        out IDWriteLocalizedStrings names
        );
    HRESULT GetInformationalStrings(
        DWRITE_INFORMATIONAL_STRING_ID informationalStringID,
        out IDWriteLocalizedStrings informationalStrings,
        out BOOL exists
        );
    DWRITE_FONT_SIMULATIONS GetSimulations(
        );
    void GetMetrics(
        out DWRITE_FONT_METRICS fontMetrics
        );
    HRESULT HasCharacter(
        uint unicodeValue,
        out BOOL exists
        );
    HRESULT CreateFontFace(
        out IDWriteFontFace fontFace
        );
}


mixin(DX_DECLARE_IID("IDWriteTextFormat", "9C906818-31D7-4FD3-A151-7C5E225DB55A"));
interface IDWriteTextFormat : IUnknown
{
extern(Windows):
    HRESULT SetTextAlignment(
        DWRITE_TEXT_ALIGNMENT textAlignment
        );
    HRESULT SetParagraphAlignment(
        DWRITE_PARAGRAPH_ALIGNMENT paragraphAlignment
        );
    HRESULT SetWordWrapping(
        DWRITE_WORD_WRAPPING wordWrapping
        );
    HRESULT SetReadingDirection(
        DWRITE_READING_DIRECTION readingDirection
        );
    HRESULT SetFlowDirection(
        DWRITE_FLOW_DIRECTION flowDirection
        );
    HRESULT SetIncrementalTabStop(
        float incrementalTabStop
        );
    HRESULT SetTrimming(
        in DWRITE_TRIMMING* trimmingOptions,
        IDWriteInlineObject trimmingSign
        );
    HRESULT SetLineSpacing(
        DWRITE_LINE_SPACING_METHOD lineSpacingMethod,
        float lineSpacing,
        float baseline
        );
    DWRITE_TEXT_ALIGNMENT GetTextAlignment(
        );
    DWRITE_PARAGRAPH_ALIGNMENT GetParagraphAlignment(
        );
    DWRITE_WORD_WRAPPING GetWordWrapping(
        );
    DWRITE_READING_DIRECTION GetReadingDirection(
        );
    DWRITE_FLOW_DIRECTION GetFlowDirection(
        );
    float GetIncrementalTabStop(
        );
    HRESULT GetTrimming(
        out DWRITE_TRIMMING trimmingOptions,
        out IDWriteInlineObject trimmingSign
        );
    HRESULT GetLineSpacing(
        out DWRITE_LINE_SPACING_METHOD lineSpacingMethod,
        out float lineSpacing,
        out float baseline
        );
    HRESULT GetFontCollection(
        out IDWriteFontCollection fontCollection
        );
    uint GetFontFamilyNameLength(
        );
    HRESULT GetFontFamilyName(
        WCHAR* fontFamilyName,
        uint nameSize
        );
    DWRITE_FONT_WEIGHT GetFontWeight(
        );
    DWRITE_FONT_STYLE GetFontStyle(
        );
    DWRITE_FONT_STRETCH GetFontStretch(
        );
    float GetFontSize(
        );
    uint GetLocaleNameLength(
        );
    HRESULT GetLocaleName(
        WCHAR* localeName,
        uint nameSize
        );
}


mixin(DX_DECLARE_IID("IDWriteTypography", "55F1112B-1DC2-4B3C-9541-F46894ED85B6"));
interface IDWriteTypography : IUnknown
{
extern(Windows):
    HRESULT AddFontFeature(
        DWRITE_FONT_FEATURE fontFeature
        );
    uint GetFontFeatureCount(
        );
    HRESULT GetFontFeature(
        uint fontFeatureIndex,
        out DWRITE_FONT_FEATURE fontFeature
        );
}


mixin(DX_DECLARE_IID("IDWriteNumberSubstitution", "14885CC9-BAB0-4f90-B6ED-5C366A2CD03D"));
interface IDWriteNumberSubstitution : IUnknown
{
extern(Windows):
}


mixin(DX_DECLARE_IID("IDWriteTextAnalysisSource", "688E1A58-5094-47C8-ADC8-FBCEA60AE92B"));
interface IDWriteTextAnalysisSource : IUnknown
{
extern(Windows):
    HRESULT GetTextAtPosition(
        uint textPosition,
        out WCHAR* textString,
        out uint textLength
        );
    HRESULT GetTextBeforePosition(
        uint textPosition,
        out WCHAR* textString,
        out uint textLength
        );
    DWRITE_READING_DIRECTION GetParagraphReadingDirection(
        );
    HRESULT GetLocaleName(
        uint textPosition,
        out uint textLength,
        out WCHAR* localeName
        );
    HRESULT GetNumberSubstitution(
        uint textPosition,
        out uint textLength,
        out IDWriteNumberSubstitution numberSubstitution
        );
}


mixin(DX_DECLARE_IID("IDWriteTextAnalysisSink", "5810CD44-0CA0-4701-B3FA-BEC5182AE4F6"));
interface IDWriteTextAnalysisSink : IUnknown
{
extern(Windows):
    HRESULT SetScriptAnalysis(
        uint textPosition,
        uint textLength,
        in DWRITE_SCRIPT_ANALYSIS* scriptAnalysis
        );
    HRESULT SetLineBreakpoints(
        uint textPosition,
        uint textLength,
        in DWRITE_LINE_BREAKPOINT* lineBreakpoints
        );
    HRESULT SetBidiLevel(
        uint textPosition,
        uint textLength,
        ubyte explicitLevel,
        ubyte resolvedLevel
        );
    HRESULT SetNumberSubstitution(
        uint textPosition,
        uint textLength,
        IDWriteNumberSubstitution numberSubstitution
        );
}


mixin(DX_DECLARE_IID("IDWriteTextAnalyzer", "B7E6163E-7F46-43B4-84B3-E4E6249C365D"));
interface IDWriteTextAnalyzer : IUnknown
{
extern(Windows):
    HRESULT AnalyzeScript(
        IDWriteTextAnalysisSource analysisSource,
        uint textPosition,
        uint textLength,
        IDWriteTextAnalysisSink analysisSink
        );
    HRESULT AnalyzeBidi(
        IDWriteTextAnalysisSource analysisSource,
        uint textPosition,
        uint textLength,
        IDWriteTextAnalysisSink analysisSink
        );
    HRESULT AnalyzeNumberSubstitution(
        IDWriteTextAnalysisSource analysisSource,
        uint textPosition,
        uint textLength,
        IDWriteTextAnalysisSink analysisSink
        );
    HRESULT AnalyzeLineBreakpoints(
        IDWriteTextAnalysisSource analysisSource,
        uint textPosition,
        uint textLength,
        IDWriteTextAnalysisSink analysisSink
        );
    HRESULT GetGlyphs(
        in WCHAR* textString,
        uint textLength,
        IDWriteFontFace fontFace,
        BOOL isSideways,
        BOOL isRightToLeft,
        in DWRITE_SCRIPT_ANALYSIS* scriptAnalysis,
        WCHAR* localeName,
        /*optional*/ IDWriteNumberSubstitution numberSubstitution,
        in DWRITE_TYPOGRAPHIC_FEATURES** features,
        in uint* featureRangeLengths,
        uint featureRanges,
        uint maxGlyphCount,
        ushort* clusterMap,
        DWRITE_SHAPING_TEXT_PROPERTIES* textProps,
        ushort* glyphIndices,
        DWRITE_SHAPING_GLYPH_PROPERTIES* glyphProps,
        out uint actualGlyphCount
        );
    HRESULT GetGlyphPlacements(
        in WCHAR* textString,
        in ushort* clusterMap,
        in DWRITE_SHAPING_TEXT_PROPERTIES* textProps,
        uint textLength,
        in ushort* glyphIndices,
        in DWRITE_SHAPING_GLYPH_PROPERTIES* glyphProps,
        uint glyphCount,
        IDWriteFontFace fontFace,
        float fontEmSize,
        BOOL isSideways,
        BOOL isRightToLeft,
        in DWRITE_SCRIPT_ANALYSIS* scriptAnalysis,
        WCHAR* localeName,
        in DWRITE_TYPOGRAPHIC_FEATURES** features,
        in uint* featureRangeLengths,
        uint featureRanges,
        float* glyphAdvances,
        DWRITE_GLYPH_OFFSET* glyphOffsets
        );
    HRESULT GetGdiCompatibleGlyphPlacements(
        in WCHAR* textString,
        in ushort* clusterMap,
        in DWRITE_SHAPING_TEXT_PROPERTIES* textProps,
        uint textLength,
        in ushort* glyphIndices,
        in DWRITE_SHAPING_GLYPH_PROPERTIES* glyphProps,
        uint glyphCount,
        IDWriteFontFace fontFace,
        float fontEmSize,
        float pixelsPerDip,
        in DWRITE_MATRIX* transform,
        BOOL useGdiNatural,
        BOOL isSideways,
        BOOL isRightToLeft,
        in DWRITE_SCRIPT_ANALYSIS* scriptAnalysis,
        in WCHAR* localeName,
        in DWRITE_TYPOGRAPHIC_FEATURES** features,
        in uint* featureRangeLengths,
        uint featureRanges,
        float* glyphAdvances,
        DWRITE_GLYPH_OFFSET* glyphOffsets
        );
}


mixin(DX_DECLARE_IID("IDWriteInlineObject", "8339FDE3-106F-47ab-8373-1C6295EB10B3"));
interface IDWriteInlineObject : IUnknown
{
extern(Windows):
    HRESULT Draw(
        void* clientDrawingContext,
        IDWriteTextRenderer renderer,
        float originX,
        float originY,
        BOOL isSideways,
        BOOL isRightToLeft,
        /*optional*/ IUnknown clientDrawingEffect = null
        );
    HRESULT GetMetrics(
        out DWRITE_INLINE_OBJECT_METRICS metrics
        );
    HRESULT GetOverhangMetrics(
        out DWRITE_OVERHANG_METRICS overhangs
        );
    HRESULT GetBreakConditions(
        out DWRITE_BREAK_CONDITION breakConditionBefore,
        out DWRITE_BREAK_CONDITION breakConditionAfter
        );
}


mixin(DX_DECLARE_IID("IDWritePixelSnapping", "EAF3A2DA-ECF4-4D24-B644-B34F6842024B"));
interface IDWritePixelSnapping : IUnknown
{
extern(Windows):
    HRESULT IsPixelSnappingDisabled(
        void* clientDrawingContext,
        out BOOL isDisabled
        );
    HRESULT GetCurrentTransform(
        void* clientDrawingContext,
        out DWRITE_MATRIX transform
        );
    HRESULT GetPixelsPerDip(
        void* clientDrawingContext,
        out float pixelsPerDip
        );
}


mixin(DX_DECLARE_IID("IDWriteTextRenderer", "EF8A8135-5CC6-45FE-8825-C5A0724EB819"));
interface IDWriteTextRenderer : IDWritePixelSnapping
{
extern(Windows):
    HRESULT DrawGlyphRun(
        void* clientDrawingContext,
        float baselineOriginX,
        float baselineOriginY,
        DWRITE_MEASURING_MODE measuringMode,
        in DWRITE_GLYPH_RUN* glyphRun,
        in DWRITE_GLYPH_RUN_DESCRIPTION* glyphRunDescription,
        /*optional*/ IUnknown clientDrawingEffect = null
        );
    HRESULT DrawUnderline(
        void* clientDrawingContext,
        float baselineOriginX,
        float baselineOriginY,
        in DWRITE_UNDERLINE* underline,
        /*optional*/ IUnknown clientDrawingEffect = null
        );
    HRESULT DrawStrikethrough(
        void* clientDrawingContext,
        float baselineOriginX,
        float baselineOriginY,
        in DWRITE_STRIKETHROUGH* strikethrough,
        /*optional*/ IUnknown clientDrawingEffect = null
        );
    HRESULT DrawInlineObject(
        void* clientDrawingContext,
        float originX,
        float originY,
        IDWriteInlineObject inlineObject,
        BOOL isSideways,
        BOOL isRightToLeft,
        /*optional*/ IUnknown clientDrawingEffect = null
        );
}


mixin(DX_DECLARE_IID("IDWriteTextLayout", "53737037-6D14-410B-9BFE-0B182BB70961"));
interface IDWriteTextLayout : IDWriteTextFormat
{
extern(Windows):
    HRESULT SetMaxWidth(
        float maxWidth
        );
    HRESULT SetMaxHeight(
        float maxHeight
        );
    HRESULT SetFontCollection(
        IDWriteFontCollection fontCollection,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetFontFamilyName(
        in WCHAR* fontFamilyName,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetFontWeight(
        DWRITE_FONT_WEIGHT fontWeight,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetFontStyle(
        DWRITE_FONT_STYLE fontStyle,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetFontStretch(
        DWRITE_FONT_STRETCH fontStretch,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetFontSize(
        float fontSize,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetUnderline(
        BOOL hasUnderline,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetStrikethrough(
        BOOL hasStrikethrough,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetDrawingEffect(
        IUnknown drawingEffect,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetInlineObject(
        IDWriteInlineObject inlineObject,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetTypography(
        IDWriteTypography typography,
        DWRITE_TEXT_RANGE textRange
        );
    HRESULT SetLocaleName(
        in WCHAR* localeName,
        DWRITE_TEXT_RANGE textRange
        );
    float GetMaxWidth(
        );
    float GetMaxHeight(
        );
    HRESULT GetFontCollection(
        uint currentPosition,
        out IDWriteFontCollection fontCollection,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetFontFamilyNameLength(
        uint currentPosition,
        out uint nameLength,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetFontFamilyName(
        uint currentPosition,
        WCHAR* fontFamilyName,
        uint nameSize,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetFontWeight(
        uint currentPosition,
        out DWRITE_FONT_WEIGHT fontWeight,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetFontStyle(
        uint currentPosition,
        out DWRITE_FONT_STYLE fontStyle,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetFontStretch(
        uint currentPosition,
        out DWRITE_FONT_STRETCH fontStretch,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetFontSize(
        uint currentPosition,
        out float fontSize,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetUnderline(
        uint currentPosition,
        out BOOL hasUnderline,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetStrikethrough(
        uint currentPosition,
        out BOOL hasStrikethrough,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetDrawingEffect(
        uint currentPosition,
        out IUnknown drawingEffect,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetInlineObject(
        uint currentPosition,
        out IDWriteInlineObject inlineObject,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetTypography(
        uint currentPosition,
        out IDWriteTypography typography,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetLocaleNameLength(
        uint currentPosition,
        out uint nameLength,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT GetLocaleName(
        uint currentPosition,
        WCHAR* localeName,
        uint nameSize,
        DWRITE_TEXT_RANGE* textRange = null
        );
    HRESULT Draw(
        void* clientDrawingContext,
        IDWriteTextRenderer renderer,
        float originX,
        float originY
        );
    HRESULT GetLineMetrics(
        DWRITE_LINE_METRICS* lineMetrics,
        uint maxLineCount,
        out uint actualLineCount
        );
    HRESULT GetMetrics(
        out DWRITE_TEXT_METRICS textMetrics
        );
    HRESULT GetOverhangMetrics(
        out DWRITE_OVERHANG_METRICS overhangs
        );
    HRESULT GetClusterMetrics(
        DWRITE_CLUSTER_METRICS* clusterMetrics,
        uint maxClusterCount,
        out uint actualClusterCount
        );
    HRESULT DetermineMinWidth(
        out float minWidth
        );
    HRESULT HitTestPoint(
        float pointX,
        float pointY,
        out BOOL isTrailingHit,
        out BOOL isInside,
        out DWRITE_HIT_TEST_METRICS hitTestMetrics
        );
    HRESULT HitTestTextPosition(
        uint textPosition,
        BOOL isTrailingHit,
        out float pointX,
        out float pointY,
        out DWRITE_HIT_TEST_METRICS hitTestMetrics
        );
    HRESULT HitTestTextRange(
        uint textPosition,
        uint textLength,
        float originX,
        float originY,
        DWRITE_HIT_TEST_METRICS* hitTestMetrics,
        uint maxHitTestMetricsCount,
        out uint actualHitTestMetricsCount
        );
}


mixin(DX_DECLARE_IID("IDWriteBitmapRenderTarget", "5E5A32A3-8DFF-4773-9FF6-0696EAB77267"));
interface IDWriteBitmapRenderTarget : IUnknown
{
extern(Windows):
    HRESULT DrawGlyphRun(
        float baselineOriginX,
        float baselineOriginY,
        DWRITE_MEASURING_MODE measuringMode,
        in DWRITE_GLYPH_RUN* glyphRun,
        IDWriteRenderingParams renderingParams,
        COLORREF textColor,
        RECT* blackBoxRect = null
        );
    HDC GetMemoryDC(
        );
    float GetPixelsPerDip(
        );
    HRESULT SetPixelsPerDip(
        float pixelsPerDip
        );
    HRESULT GetCurrentTransform(
        out DWRITE_MATRIX transform
        );
    HRESULT SetCurrentTransform(
        in DWRITE_MATRIX* transform
        );
    HRESULT GetSize(
        out SIZE size
        );
    HRESULT Resize(
        uint width,
        uint height
        );
}


mixin(DX_DECLARE_IID("IDWriteGdiInterop", "1EDD9491-9853-4299-898F-6432983B6F3A"));
interface IDWriteGdiInterop : IUnknown
{
extern(Windows):
    HRESULT CreateFontFromLOGFONT(
        in LOGFONTW* logFont,
        out IDWriteFont font
        );
    HRESULT ConvertFontToLOGFONT(
        IDWriteFont font,
        out LOGFONTW logFont,
        out BOOL isSystemFont
        );
    HRESULT ConvertFontFaceToLOGFONT(
        IDWriteFontFace font,
        out LOGFONTW logFont
        );
    HRESULT CreateFontFaceFromHdc(
        HDC hdc,
        out IDWriteFontFace fontFace
        );
    HRESULT CreateBitmapRenderTarget(
        HDC hdc,
        uint width,
        uint height,
        out IDWriteBitmapRenderTarget renderTarget
        );
}


mixin(DX_DECLARE_IID("IDWriteGlyphRunAnalysis", "7D97DBF7-E085-42D4-81E3-6A883BDED118"));
interface IDWriteGlyphRunAnalysis : IUnknown
{
extern(Windows):
    HRESULT GetAlphaTextureBounds(
        DWRITE_TEXTURE_TYPE textureType,
        out RECT textureBounds
        );
    HRESULT CreateAlphaTexture(
        DWRITE_TEXTURE_TYPE textureType,
        in RECT* textureBounds,
        ubyte* alphaValues,
        uint bufferSize
        );
    HRESULT GetAlphaBlendParams(
        IDWriteRenderingParams renderingParams,
        out float blendGamma,
        out float blendEnhancedContrast,
        out float blendClearTypeLevel
        );
}


mixin(DX_DECLARE_IID("IDWriteFactory", "B859EE5A-D838-4B5B-A2E8-1ADC7D93DB48"));
interface IDWriteFactory : IUnknown
{
extern(Windows):
    HRESULT GetSystemFontCollection(
        out IDWriteFontCollection fontCollection,
        BOOL checkForUpdates = FALSE
        );
    HRESULT CreateCustomFontCollection(
        IDWriteFontCollectionLoader collectionLoader,
        in void* collectionKey,
        uint collectionKeySize,
        out IDWriteFontCollection fontCollection
        );
    HRESULT RegisterFontCollectionLoader(
        IDWriteFontCollectionLoader fontCollectionLoader
        );
    HRESULT UnregisterFontCollectionLoader(
        IDWriteFontCollectionLoader fontCollectionLoader
        );
    HRESULT CreateFontFileReference(
        in WCHAR* filePath,
        in FILETIME* lastWriteTime,
        out IDWriteFontFile fontFile
        );
    HRESULT CreateCustomFontFileReference(
        in void* fontFileReferenceKey,
        uint fontFileReferenceKeySize,
        IDWriteFontFileLoader fontFileLoader,
        out IDWriteFontFile fontFile
        );
    HRESULT CreateFontFace(
        DWRITE_FONT_FACE_TYPE fontFaceType,
        uint numberOfFiles,
        in IDWriteFontFile* fontFiles,
        uint faceIndex,
        DWRITE_FONT_SIMULATIONS fontFaceSimulationFlags,
        out IDWriteFontFace fontFace
        );
    HRESULT CreateRenderingParams(
        out IDWriteRenderingParams renderingParams
        );
    HRESULT CreateMonitorRenderingParams(
        HMONITOR monitor,
        out IDWriteRenderingParams renderingParams
        );
    HRESULT CreateCustomRenderingParams(
        float gamma,
        float enhancedContrast,
        float clearTypeLevel,
        DWRITE_PIXEL_GEOMETRY pixelGeometry,
        DWRITE_RENDERING_MODE renderingMode,
        out IDWriteRenderingParams renderingParams
        );
    HRESULT RegisterFontFileLoader(
        IDWriteFontFileLoader fontFileLoader
        );
    HRESULT UnregisterFontFileLoader(
        IDWriteFontFileLoader fontFileLoader
        );
    HRESULT CreateTextFormat(
        in WCHAR* fontFamilyName,
        /*optional*/ IDWriteFontCollection fontCollection,
        DWRITE_FONT_WEIGHT fontWeight,
        DWRITE_FONT_STYLE fontStyle,
        DWRITE_FONT_STRETCH fontStretch,
        float fontSize,
        in WCHAR* localeName,
        out IDWriteTextFormat textFormat
        );
    HRESULT CreateTypography(
        out IDWriteTypography typography
        );
    HRESULT GetGdiInterop(
        out IDWriteGdiInterop gdiInterop
        );
    HRESULT CreateTextLayout(
        in WCHAR* string,
        uint stringLength,
        IDWriteTextFormat textFormat,
        float maxWidth,
        float maxHeight,
        out IDWriteTextLayout textLayout
        );
    HRESULT CreateGdiCompatibleTextLayout(
        in WCHAR* string,
        uint stringLength,
        IDWriteTextFormat textFormat,
        float layoutWidth,
        float layoutHeight,
        float pixelsPerDip,
        in DWRITE_MATRIX* transform,
        BOOL useGdiNatural,
        out IDWriteTextLayout textLayout
        );
    HRESULT CreateEllipsisTrimmingSign(
        IDWriteTextFormat textFormat,
        out IDWriteInlineObject trimmingSign
        );
    HRESULT CreateTextAnalyzer(
        out IDWriteTextAnalyzer textAnalyzer
        );
    HRESULT CreateNumberSubstitution(
        DWRITE_NUMBER_SUBSTITUTION_METHOD substitutionMethod,
        in WCHAR* localeName,
        BOOL ignoreUserOverride,
        out IDWriteNumberSubstitution numberSubstitution
        );
    HRESULT CreateGlyphRunAnalysis(
        in DWRITE_GLYPH_RUN* glyphRun,
        float pixelsPerDip,
        in DWRITE_MATRIX* transform,
        DWRITE_RENDERING_MODE renderingMode,
        DWRITE_MEASURING_MODE measuringMode,
        float baselineOriginX,
        float baselineOriginY,
        out IDWriteGlyphRunAnalysis glyphRunAnalysis
        );

}


extern(Windows)
{
HRESULT DWriteCreateFactory(
    DWRITE_FACTORY_TYPE factoryType,
    REFIID iid,
    out IUnknown factory
    );
}

