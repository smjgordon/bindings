// D Bindings for DirectX
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.x3daudio;


import win32.directx.dxinternal;
public import win32.directx.dxpublic;
import win32.directx.xaudio2;
import win32.windows;
import std.c.windows.com;
import core.stdc.math;


alias std.c.windows.com.IUnknown IUnknown;
alias std.c.windows.com.GUID GUID;
alias std.c.windows.com.IID IID;


version(DXSDK_11_0)
{
    pragma(lib, "x3daudio.lib");
}
else version(DXSDK_11_1)
{
    //pragma(lib, "x3daudio.lib");
}
else
{
    static assert(false, "DirectX SDK version either unsupported or undefined");
}


/////////////////////////
// Sanity checks against canocial sizes from VS2010 C++ test applet

// Enums

// Structs
version(X86)
{
static assert(X3DAUDIO_DISTANCE_CURVE_POINT.sizeof == 8);
static assert(X3DAUDIO_DISTANCE_CURVE.sizeof == 8);
static assert(X3DAUDIO_CONE.sizeof == 32);
static assert(X3DAUDIO_LISTENER.sizeof == 52);
static assert(X3DAUDIO_EMITTER.sizeof == 100);
static assert(X3DAUDIO_DSP_SETTINGS.sizeof == 48);
}
version(X86_64)
{
static assert(X3DAUDIO_DISTANCE_CURVE_POINT.sizeof == 8);
static assert(X3DAUDIO_DISTANCE_CURVE.sizeof == 12);
static assert(X3DAUDIO_CONE.sizeof == 32);
static assert(X3DAUDIO_LISTENER.sizeof == 56);
static assert(X3DAUDIO_EMITTER.sizeof == 128);
static assert(X3DAUDIO_DSP_SETTINGS.sizeof == 56);
}


enum X3DAUDIO_HANDLE_BYTESIZE = 20;

enum X3DAUDIO_PI = 3.141592654f;
enum X3DAUDIO_2PI = 6.283185307f;

enum X3DAUDIO_SPEED_OF_SOUND = 343.5f;

enum X3DAUDIO_CALCULATE_MATRIX          = 0x00000001;
enum X3DAUDIO_CALCULATE_DELAY           = 0x00000002;
enum X3DAUDIO_CALCULATE_LPF_DIRECT      = 0x00000004;
enum X3DAUDIO_CALCULATE_LPF_REVERB      = 0x00000008;
enum X3DAUDIO_CALCULATE_REVERB          = 0x00000010;
enum X3DAUDIO_CALCULATE_DOPPLER         = 0x00000020;
enum X3DAUDIO_CALCULATE_EMITTER_ANGLE   = 0x00000040;

enum X3DAUDIO_CALCULATE_ZEROCENTER      = 0x00010000;
enum X3DAUDIO_CALCULATE_REDIRECT_TO_LFE = 0x00020000;


X3DAUDIO_DISTANCE_CURVE_POINT[2] X3DAudioDefault_LinearCurvePoints;
X3DAUDIO_DISTANCE_CURVE X3DAudioDefault_LinearCurve;


static this()
{
    X3DAudioDefault_LinearCurvePoints[0] = X3DAUDIO_DISTANCE_CURVE_POINT(0.0f, 1.0f);
    X3DAudioDefault_LinearCurvePoints[1] = X3DAUDIO_DISTANCE_CURVE_POINT(1.0f, 0.0f);
    X3DAudioDefault_LinearCurve = X3DAUDIO_DISTANCE_CURVE( &X3DAudioDefault_LinearCurvePoints[0], 2 );
}


alias D3DVECTOR X3DAUDIO_VECTOR;

alias ubyte[X3DAUDIO_HANDLE_BYTESIZE] X3DAUDIO_HANDLE;


struct X3DAUDIO_DISTANCE_CURVE_POINT
{
    float Distance;
    float DSPSetting;
};


align(4):
struct X3DAUDIO_DISTANCE_CURVE
{
    X3DAUDIO_DISTANCE_CURVE_POINT* pPoints;
    uint PointCount;
}


struct X3DAUDIO_CONE
{
    float InnerAngle;
    float OuterAngle;
    float InnerVolume;
    float OuterVolume;
    float InnerLPF;
    float OuterLPF;
    float InnerReverb;
    float OuterReverb;
}


immutable X3DAUDIO_CONE X3DAudioDefault_DirectionalCone = { X3DAUDIO_PI/2, X3DAUDIO_PI, 1.0f, 0.708f, 0.0f, 0.25f, 0.708f, 1.0f };


struct X3DAUDIO_LISTENER
{
    X3DAUDIO_VECTOR OrientFront;
    X3DAUDIO_VECTOR OrientTop;
    X3DAUDIO_VECTOR Position;
    X3DAUDIO_VECTOR Velocity;
    X3DAUDIO_CONE* pCone;
}


struct X3DAUDIO_EMITTER
{
    X3DAUDIO_CONE* pCone;
    X3DAUDIO_VECTOR OrientFront;
    X3DAUDIO_VECTOR OrientTop;
    X3DAUDIO_VECTOR Position;
    X3DAUDIO_VECTOR Velocity;
    float InnerRadius;
    float InnerRadiusAngle;
    uint ChannelCount;
    float ChannelRadius;
    float* pChannelAzimuths;
    X3DAUDIO_DISTANCE_CURVE* pVolumeCurve;
    X3DAUDIO_DISTANCE_CURVE* pLFECurve;
    X3DAUDIO_DISTANCE_CURVE* pLPFDirectCurve;
    X3DAUDIO_DISTANCE_CURVE* pLPFReverbCurve;
    X3DAUDIO_DISTANCE_CURVE* pReverbCurve;
    float CurveDistanceScaler;
    float DopplerScaler;
}


struct X3DAUDIO_DSP_SETTINGS
{
    float* pMatrixCoefficients;
    float* pDelayTimes;
    uint SrcChannelCount;
    uint DstChannelCount;
    float LPFDirectCoefficient;
    float LPFReverbCoefficient;
    float ReverbLevel;
    float DopplerFactor;
    float EmitterToListenerAngle;
    float EmitterToListenerDistance;
    float EmitterVelocityComponent;
    float ListenerVelocityComponent;
}


extern(Windows)
{
void X3DAudioInitialize(
    uint SpeakerChannelMask,
    float SpeedOfSound,
    ubyte* Instance);

void X3DAudioCalculate(
    in ubyte* Instance,
    in X3DAUDIO_LISTENER* pListener,
    in X3DAUDIO_EMITTER* pEmitter,
    uint Flags,
    ref X3DAUDIO_DSP_SETTINGS pDSPSettings);
}
