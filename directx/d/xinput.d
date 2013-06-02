// D Bindings for DirectX
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.xinput;


import win32.directx.dxinternal;
public import win32.directx.dxpublic;
import win32.windows;
import std.c.windows.com;
import core.stdc.math;


alias std.c.windows.com.IUnknown IUnknown;
alias std.c.windows.com.GUID GUID;
alias std.c.windows.com.IID IID;


version(DXSDK_11_0)
{
    pragma(lib, "xinput.lib");
}
else version(DXSDK_11_1)
{
    pragma(lib, "xinput.lib");
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
static assert(XINPUT_GAMEPAD.sizeof == 12);
static assert(XINPUT_STATE.sizeof == 16);
static assert(XINPUT_VIBRATION.sizeof == 4);
static assert(XINPUT_CAPABILITIES.sizeof == 20);
static assert(XINPUT_BATTERY_INFORMATION.sizeof == 2);
static assert(XINPUT_KEYSTROKE.sizeof == 8);
}
version(X86_64)
{
static assert(XINPUT_GAMEPAD.sizeof == 12);
static assert(XINPUT_STATE.sizeof == 16);
static assert(XINPUT_VIBRATION.sizeof == 4);
static assert(XINPUT_CAPABILITIES.sizeof == 20);
static assert(XINPUT_BATTERY_INFORMATION.sizeof == 2);
static assert(XINPUT_KEYSTROKE.sizeof == 8);
}


enum XINPUT_DEVTYPE_GAMEPAD = 0x01;
enum XINPUT_DEVSUBTYPE_GAMEPAD = 0x01;
enum XINPUT_DEVSUBTYPE_WHEEL = 0x02;
enum XINPUT_DEVSUBTYPE_ARCADE_STICK = 0x03;
enum XINPUT_DEVSUBTYPE_FLIGHT_SICK = 0x04;
enum XINPUT_DEVSUBTYPE_DANCE_PAD = 0x05;
enum XINPUT_DEVSUBTYPE_GUITAR = 0x06;
enum XINPUT_DEVSUBTYPE_DRUM_KIT = 0x08;

enum XINPUT_CAPS_VOICE_SUPPORTED = 0x0004;

enum XINPUT_GAMEPAD_DPAD_UP = 0x0001;
enum XINPUT_GAMEPAD_DPAD_DOWN = 0x0002;
enum XINPUT_GAMEPAD_DPAD_LEFT = 0x0004;
enum XINPUT_GAMEPAD_DPAD_RIGHT = 0x0008;
enum XINPUT_GAMEPAD_START = 0x0010;
enum XINPUT_GAMEPAD_BACK = 0x0020;
enum XINPUT_GAMEPAD_LEFT_THUMB = 0x0040;
enum XINPUT_GAMEPAD_RIGHT_THUMB = 0x0080;
enum XINPUT_GAMEPAD_LEFT_SHOULDER = 0x0100;
enum XINPUT_GAMEPAD_RIGHT_SHOULDER = 0x0200;
enum XINPUT_GAMEPAD_A = 0x1000;
enum XINPUT_GAMEPAD_B = 0x2000;
enum XINPUT_GAMEPAD_X = 0x4000;
enum XINPUT_GAMEPAD_Y = 0x8000;

enum XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE = 7849;
enum XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE = 8689;
enum XINPUT_GAMEPAD_TRIGGER_THRESHOLD = 30;

enum XINPUT_FLAG_GAMEPAD = 0x00000001;

enum BATTERY_DEVTYPE_GAMEPAD = 0x00;
enum BATTERY_DEVTYPE_HEADSET = 0x01;

enum BATTERY_TYPE_DISCONNECTED = 0x00;
enum BATTERY_TYPE_WIRED = 0x01;
enum BATTERY_TYPE_ALKALINE = 0x02;
enum BATTERY_TYPE_NIMH = 0x03;
enum BATTERY_TYPE_UNKNOWN = 0xFF;

enum BATTERY_LEVEL_EMPTY = 0x00;
enum BATTERY_LEVEL_LOW = 0x01;
enum BATTERY_LEVEL_MEDIUM = 0x02;
enum BATTERY_LEVEL_FULL = 0x03;

enum XUSER_MAX_COUNT = 4;
enum XUSER_INDEX_ANY = 0x000000FF;

enum VK_PAD_A = 0x5800;
enum VK_PAD_B = 0x5801;
enum VK_PAD_X = 0x5802;
enum VK_PAD_Y = 0x5803;
enum VK_PAD_RSHOULDER = 0x5804;
enum VK_PAD_LSHOULDER = 0x5805;
enum VK_PAD_LTRIGGER = 0x5806;
enum VK_PAD_RTRIGGER = 0x5807;

enum VK_PAD_DPAD_UP = 0x5810;
enum VK_PAD_DPAD_DOWN = 0x5811;
enum VK_PAD_DPAD_LEFT = 0x5812;
enum VK_PAD_DPAD_RIGHT = 0x5813;
enum VK_PAD_START = 0x5814;
enum VK_PAD_BACK = 0x5815;
enum VK_PAD_LTHUMB_PRESS = 0x5816;
enum VK_PAD_RTHUMB_PRESS = 0x5817;

enum VK_PAD_LTHUMB_UP = 0x5820;
enum VK_PAD_LTHUMB_DOWN = 0x5821;
enum VK_PAD_LTHUMB_RIGHT = 0x5822;
enum VK_PAD_LTHUMB_LEFT = 0x5823;
enum VK_PAD_LTHUMB_UPLEFT = 0x5824;
enum VK_PAD_LTHUMB_UPRIGHT = 0x5825;
enum VK_PAD_LTHUMB_DOWNRIGHT = 0x5826;
enum VK_PAD_LTHUMB_DOWNLEFT = 0x5827;

enum VK_PAD_RTHUMB_UP = 0x5830;
enum VK_PAD_RTHUMB_DOWN = 0x5831;
enum VK_PAD_RTHUMB_RIGHT = 0x5832;
enum VK_PAD_RTHUMB_LEFT = 0x5833;
enum VK_PAD_RTHUMB_UPLEFT = 0x5834;
enum VK_PAD_RTHUMB_UPRIGHT = 0x5835;
enum VK_PAD_RTHUMB_DOWNRIGHT = 0x5836;
enum VK_PAD_RTHUMB_DOWNLEFT = 0x5837;

enum XINPUT_KEYSTROKE_KEYDOWN = 0x0001;
enum XINPUT_KEYSTROKE_KEYUP = 0x0002;
enum XINPUT_KEYSTROKE_REPEAT = 0x0004;


struct XINPUT_GAMEPAD
{
    ushort wButtons;
    ubyte bLeftTrigger;
    ubyte bRightTrigger;
    short sThumbLX;
    short sThumbLY;
    short sThumbRX;
    short sThumbRY;
}


struct XINPUT_STATE
{
    uint dwPacketNumber;
    XINPUT_GAMEPAD Gamepad;
}


struct XINPUT_VIBRATION
{
    ushort wLeftMotorSpeed;
    ushort wRightMotorSpeed;
}


struct XINPUT_CAPABILITIES
{
    ubyte Type;
    ubyte SubType;
    ushort Flags;
    XINPUT_GAMEPAD Gamepad;
    XINPUT_VIBRATION Vibration;
}


struct XINPUT_BATTERY_INFORMATION
{
    ubyte BatteryType;
    ubyte BatteryLevel;
}


struct XINPUT_KEYSTROKE
{
    ushort VirtualKey;
    wchar Unicode;
    ushort Flags;
    ubyte UserIndex;
    ubyte HidCode;
}


extern(C)
{
uint XInputGetState(
    uint dwUserIndex,
    out XINPUT_STATE pState
    );

    
uint XInputSetState(
    uint dwUserIndex,
    XINPUT_VIBRATION* pVibration
    );


uint XInputGetCapabilities(
    uint dwUserIndex,
    uint dwFlags,
    out XINPUT_CAPABILITIES pCapabilities
    );


void XInputEnable(
    BOOL enable
    );


uint XInputGetDSoundAudioDeviceGuids(
    uint dwUserIndex,
    out GUID pDSoundRenderGuid,
    out GUID pDSoundCaptureGuid
    );


uint XInputGetBatteryInformation(
    uint dwUserIndex,
    ubyte devType,
    out XINPUT_BATTERY_INFORMATION pBatteryInformation
    );


uint XInputGetKeystroke(
    uint dwUserIndex,
    uint dwReserved,
    out XINPUT_KEYSTROKE pKeystroke
    );
}

