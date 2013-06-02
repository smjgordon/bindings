// D Bindings for DirectX
// Ported by Sean Cavanaugh - WorksOnMyMachine@gmail.com

module win32.directx.xaudio2;


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
static assert(XAUDIO2_WINDOWS_PROCESSOR_SPECIFIER.sizeof == 4);
static assert(XAUDIO2_DEVICE_ROLE.sizeof == 4);

// Structs
version(X86)
{
static assert(tWAVEFORMATEX.sizeof == 18);
static assert(WAVEFORMATEXTENSIBLE.sizeof == 40);
static assert(WAVEFORMAT.sizeof == 14);
static assert(PCMWAVEFORMAT.sizeof == 16);
static assert(ADPCMCOEFSET.sizeof == 4);
static assert(ADPCMWAVEFORMAT.sizeof == 22);
static assert(XAUDIO2_DEVICE_DETAILS.sizeof == 1068);
version(DXSDK_11_0)
{
static assert(XAUDIO2_VOICE_DETAILS.sizeof == 12);
}
version(DXSDK_11_1)
{
static assert(XAUDIO2_VOICE_DETAILS.sizeof == 16);
}
static assert(XAUDIO2_SEND_DESCRIPTOR.sizeof == 8);
static assert(XAUDIO2_VOICE_SENDS.sizeof == 8);
static assert(XAUDIO2_EFFECT_DESCRIPTOR.sizeof == 12);
static assert(XAUDIO2_EFFECT_CHAIN.sizeof == 8);
static assert(XAUDIO2_FILTER_PARAMETERS.sizeof == 12);
static assert(XAUDIO2_BUFFER.sizeof == 36);
static assert(XAUDIO2_BUFFER_WMA.sizeof == 8);
static assert(XAUDIO2_VOICE_STATE.sizeof == 16);
static assert(XAUDIO2_PERFORMANCE_DATA.sizeof == 64);
static assert(XAUDIO2_DEBUG_CONFIGURATION.sizeof == 24);
}
version(X86_64)
{
static assert(tWAVEFORMATEX.sizeof == 18);
static assert(WAVEFORMATEXTENSIBLE.sizeof == 40);
static assert(WAVEFORMAT.sizeof == 14);
static assert(PCMWAVEFORMAT.sizeof == 16);
static assert(ADPCMCOEFSET.sizeof == 4);
static assert(ADPCMWAVEFORMAT.sizeof == 22);
static assert(XAUDIO2_DEVICE_DETAILS.sizeof == 1068);
version(DXSDK_11_0)
{
static assert(XAUDIO2_VOICE_DETAILS.sizeof == 12);
}
version(DXSDK_11_1)
{
static assert(XAUDIO2_VOICE_DETAILS.sizeof == 16);
}
static assert(XAUDIO2_SEND_DESCRIPTOR.sizeof == 12);
static assert(XAUDIO2_VOICE_SENDS.sizeof == 12);
static assert(XAUDIO2_EFFECT_DESCRIPTOR.sizeof == 16);
static assert(XAUDIO2_EFFECT_CHAIN.sizeof == 12);
static assert(XAUDIO2_FILTER_PARAMETERS.sizeof == 12);
static assert(XAUDIO2_BUFFER.sizeof == 44);
static assert(XAUDIO2_BUFFER_WMA.sizeof == 12);
static assert(XAUDIO2_VOICE_STATE.sizeof == 20);
static assert(XAUDIO2_PERFORMANCE_DATA.sizeof == 64);
static assert(XAUDIO2_DEBUG_CONFIGURATION.sizeof == 24);
}


enum float PIf = 3.1415926535897932384626433832795f;


enum XAUDIO2_MAX_BUFFER_BYTES = 0x80000000;
enum XAUDIO2_MAX_QUEUED_BUFFERS = 64;
enum XAUDIO2_MAX_BUFFERS_SYSTEM = 2;
enum XAUDIO2_MAX_AUDIO_CHANNELS = 64;
enum XAUDIO2_MIN_SAMPLE_RATE = 1000;
enum XAUDIO2_MAX_SAMPLE_RATE = 200000;
enum XAUDIO2_MAX_VOLUME_LEVEL = 16777216.0f;
enum XAUDIO2_MIN_FREQ_RATIO = (1/1024.0f);
enum XAUDIO2_MAX_FREQ_RATIO = 1024.0f;
enum XAUDIO2_DEFAULT_FREQ_RATIO = 2.0f;
enum XAUDIO2_MAX_FILTER_ONEOVERQ = 1.5f;
enum XAUDIO2_MAX_FILTER_FREQUENCY = 1.0f;
enum XAUDIO2_MAX_LOOP_COUNT = 254;
enum XAUDIO2_MAX_INSTANCES = 8;

enum XAUDIO2_MAX_RATIO_TIMES_RATE_XMA_MONO = 600000;
enum XAUDIO2_MAX_RATIO_TIMES_RATE_XMA_MULTICHANNEL = 300000;

enum XAUDIO2_COMMIT_NOW = 0;
enum XAUDIO2_COMMIT_ALL = 0;
enum XAUDIO2_INVALID_OPSET = 0xFFFFFFFF;
enum XAUDIO2_NO_LOOP_REGION = 0;
enum XAUDIO2_LOOP_INFINITE = 255;
enum XAUDIO2_DEFAULT_CHANNELS = 0;
enum XAUDIO2_DEFAULT_SAMPLERATE = 0;

version(DXSDK_11_0)
{
enum XAUDIO2_DEBUG_ENGINE = 0x0001;
enum XAUDIO2_VOICE_MUSIC = 0x0010;
}
enum XAUDIO2_VOICE_NOPITCH = 0x0002;
enum XAUDIO2_VOICE_NOSRC = 0x0004;
enum XAUDIO2_VOICE_USEFILTER = 0x0008;
enum XAUDIO2_PLAY_TAILS = 0x0020;
enum XAUDIO2_END_OF_STREAM = 0x0040;
enum XAUDIO2_SEND_USEFILTER = 0x0080;
version(DXSDK_11_1)
{
enum XAUDIO2_VOICE_NOSAMPLEPLAYED = 0x0100;
}

enum XAUDIO2_DEFAULT_FILTER_TYPE = XAUDIO2_FILTER_TYPE.LowPassFilter;
enum XAUDIO2_DEFAULT_FILTER_FREQUENCY = XAUDIO2_MAX_FILTER_FREQUENCY;
enum XAUDIO2_DEFAULT_FILTER_ONEOVERQ = 1.0f;

enum XAUDIO2_QUANTUM_NUMERATOR = 1;
enum XAUDIO2_QUANTUM_DENOMINATOR = 100;

//#define XAUDIO2_QUANTUM_MS (1000.0f * XAUDIO2_QUANTUM_NUMERATOR / XAUDIO2_QUANTUM_DENOMINATOR)

enum FACILITY_XAUDIO2 = 0x896;
enum XAUDIO2_E_INVALID_CALL = 0x88960001;
enum XAUDIO2_E_XMA_DECODER_ERROR = 0x88960002;
enum XAUDIO2_E_XAPO_CREATION_FAILED = 0x88960003;
enum XAUDIO2_E_DEVICE_INVALIDATED = 0x88960004;

enum XAUDIO2_WINDOWS_PROCESSOR_SPECIFIER
{
    Processor1  = 0x00000001,
    Processor2  = 0x00000002,
    Processor3  = 0x00000004,
    Processor4  = 0x00000008,
    Processor5  = 0x00000010,
    Processor6  = 0x00000020,
    Processor7  = 0x00000040,
    Processor8  = 0x00000080,
    Processor9  = 0x00000100,
    Processor10 = 0x00000200,
    Processor11 = 0x00000400,
    Processor12 = 0x00000800,
    Processor13 = 0x00001000,
    Processor14 = 0x00002000,
    Processor15 = 0x00004000,
    Processor16 = 0x00008000,
    Processor17 = 0x00010000,
    Processor18 = 0x00020000,
    Processor19 = 0x00040000,
    Processor20 = 0x00080000,
    Processor21 = 0x00100000,
    Processor22 = 0x00200000,
    Processor23 = 0x00400000,
    Processor24 = 0x00800000,
    Processor25 = 0x01000000,
    Processor26 = 0x02000000,
    Processor27 = 0x04000000,
    Processor28 = 0x08000000,
    Processor29 = 0x10000000,
    Processor30 = 0x20000000,
    Processor31 = 0x40000000,
    Processor32 = 0x80000000,
    XAUDIO2_ANY_PROCESSOR = 0xffffffff,
    XAUDIO2_DEFAULT_PROCESSOR = XAUDIO2_ANY_PROCESSOR,
}
alias XAUDIO2_WINDOWS_PROCESSOR_SPECIFIER XAUDIO2_PROCESSOR;


enum XAUDIO2_DEVICE_ROLE
{
    NotDefaultDevice            = 0x0,
    DefaultConsoleDevice        = 0x1,
    DefaultMultimediaDevice     = 0x2,
    DefaultCommunicationsDevice = 0x4,
    DefaultGameDevice           = 0x8,
    GlobalDefaultDevice         = 0xf,
    InvalidDeviceRole = ~GlobalDefaultDevice,
}

////////////////////
// audiodefs
align(1):
struct tWAVEFORMATEX
{
align(1):
    WORD wFormatTag;
    WORD nChannels;
    DWORD nSamplesPerSec;
    DWORD nAvgBytesPerSec;
    WORD nBlockAlign;
    WORD wBitsPerSample;
    WORD cbSize;
}


align:
struct WAVEFORMATEXTENSIBLE
{
    WAVEFORMATEX Format;
    union Samples
    {
        WORD wValidBitsPerSample;
        WORD wSamplesPerBlock;
        WORD wReserved;
    };
    DWORD dwChannelMask;
    GUID SubFormat;
}


align(1):
struct WAVEFORMAT
{
align(1):
    WORD wFormatTag;
    WORD nChannels;
    DWORD nSamplesPerSec;
    DWORD nAvgBytesPerSec;
    WORD nBlockAlign;
}


align(1):
struct PCMWAVEFORMAT
{
align(1):
    WAVEFORMAT wf;
    WORD wBitsPerSample;
}


align(1):
struct ADPCMCOEFSET
{
align(1):
    short iCoef1;
    short iCoef2;
}


align(1):
struct ADPCMWAVEFORMAT
{
align(1):
    WAVEFORMATEX wfx;
    WORD wSamplesPerBlock;
    WORD wNumCoef;
    ADPCMCOEFSET[0] aCoef;//variable sized struct . . .
}


enum WAVE_FORMAT_PCM = 0x0001;
enum WAVE_FORMAT_ADPCM = 0x0002;
enum WAVE_FORMAT_UNKNOWN = 0x0000;
enum WAVE_FORMAT_IEEE_FLOAT = 0x0003;
enum WAVE_FORMAT_MPEGLAYER3 = 0x0055;
enum WAVE_FORMAT_DOLBY_AC3_SPDIF = 0x0092;
enum WAVE_FORMAT_WMAUDIO2 = 0x0161;
enum WAVE_FORMAT_WMAUDIO3 = 0x0162;
enum WAVE_FORMAT_WMASPDIF = 0x0164;
enum WAVE_FORMAT_EXTENSIBLE = 0xFFFE;

mixin(DX_DECLARE_IID_RAW("KSDATAFORMAT_SUBTYPE_PCM", "00000001-0000-0010-8000-00aa00389b71"));
mixin(DX_DECLARE_IID_RAW("KSDATAFORMAT_SUBTYPE_ADPCM", "00000002-0000-0010-8000-00aa00389b71"));
mixin(DX_DECLARE_IID_RAW("KSDATAFORMAT_SUBTYPE_IEEE_FLOAT", "00000003-0000-0010-8000-00aa00389b71"));

enum SPEAKER_FRONT_LEFT            = 0x00000001;
enum SPEAKER_FRONT_RIGHT           = 0x00000002;
enum SPEAKER_FRONT_CENTER          = 0x00000004;
enum SPEAKER_LOW_FREQUENCY         = 0x00000008;
enum SPEAKER_BACK_LEFT             = 0x00000010;
enum SPEAKER_BACK_RIGHT            = 0x00000020;
enum SPEAKER_FRONT_LEFT_OF_CENTER  = 0x00000040;
enum SPEAKER_FRONT_RIGHT_OF_CENTER = 0x00000080;
enum SPEAKER_BACK_CENTER           = 0x00000100;
enum SPEAKER_SIDE_LEFT             = 0x00000200;
enum SPEAKER_SIDE_RIGHT            = 0x00000400;
enum SPEAKER_TOP_CENTER            = 0x00000800;
enum SPEAKER_TOP_FRONT_LEFT        = 0x00001000;
enum SPEAKER_TOP_FRONT_CENTER      = 0x00002000;
enum SPEAKER_TOP_FRONT_RIGHT       = 0x00004000;
enum SPEAKER_TOP_BACK_LEFT         = 0x00008000;
enum SPEAKER_TOP_BACK_CENTER       = 0x00010000;
enum SPEAKER_TOP_BACK_RIGHT        = 0x00020000;
enum SPEAKER_RESERVED              = 0x7FFC0000;
enum SPEAKER_ALL                   = 0x80000000;

enum SPEAKER_MONO             = (SPEAKER_FRONT_CENTER);
enum SPEAKER_STEREO           = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT);
enum SPEAKER_2POINT1          = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT | SPEAKER_LOW_FREQUENCY);
enum SPEAKER_SURROUND         = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT | SPEAKER_FRONT_CENTER | SPEAKER_BACK_CENTER);
enum SPEAKER_QUAD             = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT | SPEAKER_BACK_LEFT | SPEAKER_BACK_RIGHT);
enum SPEAKER_4POINT1          = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT | SPEAKER_LOW_FREQUENCY | SPEAKER_BACK_LEFT | SPEAKER_BACK_RIGHT);
enum SPEAKER_5POINT1          = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT | SPEAKER_FRONT_CENTER | SPEAKER_LOW_FREQUENCY | SPEAKER_BACK_LEFT | SPEAKER_BACK_RIGHT);
enum SPEAKER_7POINT1          = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT | SPEAKER_FRONT_CENTER | SPEAKER_LOW_FREQUENCY | SPEAKER_BACK_LEFT | SPEAKER_BACK_RIGHT | SPEAKER_FRONT_LEFT_OF_CENTER | SPEAKER_FRONT_RIGHT_OF_CENTER);
enum SPEAKER_5POINT1_SURROUND = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT | SPEAKER_FRONT_CENTER | SPEAKER_LOW_FREQUENCY | SPEAKER_SIDE_LEFT | SPEAKER_SIDE_RIGHT);
enum SPEAKER_7POINT1_SURROUND = (SPEAKER_FRONT_LEFT | SPEAKER_FRONT_RIGHT | SPEAKER_FRONT_CENTER | SPEAKER_LOW_FREQUENCY | SPEAKER_BACK_LEFT | SPEAKER_BACK_RIGHT | SPEAKER_SIDE_LEFT  | SPEAKER_SIDE_RIGHT);

// audiodefs
////////////////////


align(1):
struct XAUDIO2_DEVICE_DETAILS
{
align(1):
    wchar[256] DeviceID;
    wchar[256] DisplayName;
    XAUDIO2_DEVICE_ROLE Role;
    WAVEFORMATEXTENSIBLE OutputFormat;
}


version(DXSDK_11_0)
{
	align(1):
	struct XAUDIO2_VOICE_DETAILS
	{
	align(1):
		uint CreationFlags;
		uint InputChannels;
		uint InputSampleRate;
	}
}
version(DXSDK_11_1)
{
	align(1):
	struct XAUDIO2_VOICE_DETAILS
	{
		align(1):
		uint CreationFlags;
		uint ActiveFlags;
		uint InputChannels;
		uint InputSampleRate;
	}
}


align(1):
struct XAUDIO2_SEND_DESCRIPTOR
{
align(1):
    uint Flags;
    IXAudio2Voice pOutputVoice;
}


align(1):
struct XAUDIO2_VOICE_SENDS
{
align(1):
    uint SendCount;
    XAUDIO2_SEND_DESCRIPTOR* pSends;
}


align(1):
struct XAUDIO2_EFFECT_DESCRIPTOR
{
align(1):
    IUnknown pEffect;
    BOOL InitialState;
    uint OutputChannels;
}


align(1):
struct XAUDIO2_EFFECT_CHAIN
{
align(1):
    uint EffectCount;
    XAUDIO2_EFFECT_DESCRIPTOR* pEffectDescriptors;
}


version(DXSDK_11_0)
{
	enum XAUDIO2_FILTER_TYPE
	{
		LowPassFilter,
		BandPassFilter,
		HighPassFilter,
		NotchFilter,
	}
}
version(DXSDK_11_1)
{
	enum XAUDIO2_FILTER_TYPE
	{
		LowPassFilter,
		BandPassFilter,
		HighPassFilter,
		NotchFilter,
		LowPassOnePoleFilter,
		HighPassOnePoleFilter,
	}
}


align(1):
struct XAUDIO2_FILTER_PARAMETERS
{
align(1):
    XAUDIO2_FILTER_TYPE Type;
    float Frequency;
    float OneOverQ;
}


align(1):
struct XAUDIO2_BUFFER
{
align(1):
    uint Flags;
    uint AudioBytes;
    const ubyte* pAudioData;
    uint PlayBegin;
    uint PlayLength;
    uint LoopBegin;
    uint LoopLength;
    uint LoopCount;
    void* pContext;
}


align(1):
struct XAUDIO2_BUFFER_WMA
{
align(1):
    const uint* pDecodedPacketCumulativeBytes;
    uint PacketCount;
}


align(1):
struct XAUDIO2_VOICE_STATE
{
align(1):
    void* pCurrentBufferContext;
    uint BuffersQueued;
    ulong SamplesPlayed;
}


align(1):
struct XAUDIO2_PERFORMANCE_DATA
{
align(1):
    ulong AudioCyclesSinceLastQuery;
    ulong TotalCyclesSinceLastQuery;
    uint MinimumCyclesPerQuantum;
    uint MaximumCyclesPerQuantum;
    uint MemoryUsageInBytes;
    uint CurrentLatencyInSamples;
    uint GlitchesSinceEngineStarted;
    uint ActiveSourceVoiceCount;
    uint TotalSourceVoiceCount;
    uint ActiveSubmixVoiceCount;
    uint ActiveResamplerCount;
    uint ActiveMatrixMixCount;
    uint ActiveXmaSourceVoices;
    uint ActiveXmaStreams;
}


align(1):
struct XAUDIO2_DEBUG_CONFIGURATION
{
align(1):
    uint TraceMask;
    uint BreakMask;
    BOOL LogThreadID;
    BOOL LogFileline;
    BOOL LogFunctionName;
    BOOL LogTiming;
}



enum XAUDIO2_LOG_ERRORS     = 0x0001;
enum XAUDIO2_LOG_WARNINGS   = 0x0002;
enum XAUDIO2_LOG_INFO       = 0x0004;
enum XAUDIO2_LOG_DETAIL     = 0x0008;
enum XAUDIO2_LOG_API_CALLS  = 0x0010;
enum XAUDIO2_LOG_FUNC_CALLS = 0x0020;
enum XAUDIO2_LOG_TIMING     = 0x0040;
enum XAUDIO2_LOG_LOCKS      = 0x0080;
enum XAUDIO2_LOG_MEMORY     = 0x0100;
enum XAUDIO2_LOG_STREAMING  = 0x1000;


version(DXSDK_11_0)
{
mixin(DX_DECLARE_IID("IXAudio2", "8BCF1F58-9FE7-4583-8AC6-E2ADC465C8BB"));
interface IXAudio2 : IUnknown
{
extern(Windows):
    HRESULT GetDeviceCount(
        out uint pCount
        );
    HRESULT GetDeviceDetails(
        uint Index,
        out XAUDIO2_DEVICE_DETAILS pDeviceDetails
        );
    HRESULT Initialize(
        uint Flags = 0,
        XAUDIO2_PROCESSOR XAudio2Processor = XAUDIO2_WINDOWS_PROCESSOR_SPECIFIER.XAUDIO2_DEFAULT_PROCESSOR
        );
    HRESULT RegisterForCallbacks(
        IXAudio2EngineCallback pCallback
        );
    void UnregisterForCallbacks(
        IXAudio2EngineCallback pCallback
        );
    HRESULT CreateSourceVoice(
        out IXAudio2SourceVoice ppSourceVoice,
        in WAVEFORMATEX* pSourceFormat,
        uint Flags = 0,
        float MaxFrequencyRatio = XAUDIO2_DEFAULT_FREQ_RATIO,
        IXAudio2VoiceCallback pCallback = null,
        in XAUDIO2_VOICE_SENDS* pSendList = null,
        in XAUDIO2_EFFECT_CHAIN* pEffectChain = null
        );
    HRESULT CreateSubmixVoice(
        out IXAudio2SubmixVoice ppSubmixVoice,
        uint InputChannels,
        uint InputSampleRate,
        uint Flags = 0,
        uint ProcessingStage = 0,
        in XAUDIO2_VOICE_SENDS* pSendList = null,
        in XAUDIO2_EFFECT_CHAIN* pEffectChain = null
        );
    HRESULT CreateMasteringVoice(
        out IXAudio2MasteringVoice ppMasteringVoice,
        uint InputChannels = XAUDIO2_DEFAULT_CHANNELS,
        uint InputSampleRate = XAUDIO2_DEFAULT_SAMPLERATE,
        uint Flags = 0,
        uint DeviceIndex = 0,
        in XAUDIO2_EFFECT_CHAIN* pEffectChain = null
        );
    HRESULT StartEngine(
        );
    void StopEngine(
        );
    HRESULT CommitChanges(
        uint OperationSet
        );
    void GetPerformanceData(
        out XAUDIO2_PERFORMANCE_DATA pPerfData
        );
    void SetDebugConfiguration(
        in XAUDIO2_DEBUG_CONFIGURATION* pDebugConfiguration,
        void* pReserved = null
        );
}
}
else version(DXSDK_11_1)
{
enum AudioCategory
{
	Other = 0,
	ForegroundOnlyMedia,
	BackgroundCapableMedia,
	Communications,
	Alerts,
	SoundEffects,
	GameEffects,
	GameMedia,
};
alias AudioCategory AUDIO_STREAM_CATEGORY;

mixin(DX_DECLARE_IID("IXAudio2", "60D8DAC8-5AA1-4E8E-B597-2F5E2883D484"));
interface IXAudio2 : IUnknown
{
extern(Windows):
    HRESULT RegisterForCallbacks(
        IXAudio2EngineCallback pCallback
        );
    void UnregisterForCallbacks(
        IXAudio2EngineCallback pCallback
        );
    HRESULT CreateSourceVoice(
        out IXAudio2SourceVoice ppSourceVoice,
        in WAVEFORMATEX* pSourceFormat,
        uint Flags = 0,
        float MaxFrequencyRatio = XAUDIO2_DEFAULT_FREQ_RATIO,
        IXAudio2VoiceCallback pCallback = null,
        in XAUDIO2_VOICE_SENDS* pSendList = null,
        in XAUDIO2_EFFECT_CHAIN* pEffectChain = null
        );
    HRESULT CreateSubmixVoice(
        out IXAudio2SubmixVoice ppSubmixVoice,
        uint InputChannels,
        uint InputSampleRate,
        uint Flags = 0,
        uint ProcessingStage = 0,
        in XAUDIO2_VOICE_SENDS* pSendList = null,
        in XAUDIO2_EFFECT_CHAIN* pEffectChain = null
        );
    HRESULT CreateMasteringVoice(
        out IXAudio2MasteringVoice ppMasteringVoice,
        uint InputChannels = XAUDIO2_DEFAULT_CHANNELS,
        uint InputSampleRate = XAUDIO2_DEFAULT_SAMPLERATE,
        uint Flags = 0,
        uint DeviceIndex = 0,
        in XAUDIO2_EFFECT_CHAIN* pEffectChain = null,
		AUDIO_STREAM_CATEGORY StreamCategory = AudioCategory.GameEffects
        );
    HRESULT StartEngine(
        );
    void StopEngine(
        );
    HRESULT CommitChanges(
        uint OperationSet
        );
    void GetPerformanceData(
        out XAUDIO2_PERFORMANCE_DATA pPerfData
        );
    void SetDebugConfiguration(
        in XAUDIO2_DEBUG_CONFIGURATION* pDebugConfiguration,
        void* pReserved = null
        );
}
}


interface IXAudio2Voice : IUnknown
{
extern(Windows):
    void GetVoiceDetails(
        out XAUDIO2_VOICE_DETAILS pVoiceDetails
        );
    HRESULT SetOutputVoices(
        in XAUDIO2_VOICE_SENDS* pSendList
        );
    HRESULT SetEffectChain(
        in XAUDIO2_EFFECT_CHAIN* pEffectChain
        );
    HRESULT EnableEffect(
        uint EffectIndex,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    HRESULT DisableEffect(
        uint EffectIndex,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    void GetEffectState(
        uint EffectIndex,
        out BOOL pEnabled
        );
    HRESULT SetEffectParameters(
        uint EffectIndex,
        const void* pParameters,
        uint ParametersByteSize,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    HRESULT GetEffectParameters(
        uint EffectIndex,
        void* pParameters,
        uint ParametersByteSize);
    HRESULT SetFilterParameters(
        in XAUDIO2_FILTER_PARAMETERS* pParameters,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    void GetFilterParameters(
        out XAUDIO2_FILTER_PARAMETERS pParameters
        );
    HRESULT SetOutputFilterParameters(
        IXAudio2Voice pDestinationVoice,
        in XAUDIO2_FILTER_PARAMETERS* pParameters,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    void GetOutputFilterParameters(
        IXAudio2Voice pDestinationVoice,
        out XAUDIO2_FILTER_PARAMETERS pParameters
        );
    HRESULT SetVolume(
        float Volume,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    void GetVolume(
        out float pVolume
        );
    HRESULT SetChannelVolumes(
        uint Channels,
        const float* pVolumes,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    void GetChannelVolumes(
        uint Channels,
        float* pVolumes
        );
    HRESULT SetOutputMatrix(
        IXAudio2Voice pDestinationVoice,
        uint SourceChannels,
        uint DestinationChannels,
        const float* pLevelMatrix,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    void GetOutputMatrix(
        IXAudio2Voice pDestinationVoice,
        uint SourceChannels,
        uint DestinationChannels,
        float* pLevelMatrix
        );
    void DestroyVoice(
        );
}


interface IXAudio2SourceVoice : IXAudio2Voice
{
extern(Windows):
    HRESULT Start(
        uint Flags = 0,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    HRESULT Stop(
        uint Flags = 0,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    HRESULT SubmitSourceBuffer(
        in XAUDIO2_BUFFER* pBuffer,
        in XAUDIO2_BUFFER_WMA* pBufferWMA = null
        );
    HRESULT FlushSourceBuffers(
        );
    HRESULT Discontinuity(
        );
    HRESULT ExitLoop(
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
version(DXSDK_11_0)
{
    void GetState(
        out XAUDIO2_VOICE_STATE pVoiceState
        );
}
else version(DXSDK_11_1)
{
    void GetState(
				  out XAUDIO2_VOICE_STATE pVoiceState,
				  uint Flags
				  );
}
else
{
    static assert(false, "DirectX SDK version either unsupported or undefined");
}
    HRESULT SetFrequencyRatio(
        float Ratio,
        uint OperationSet = XAUDIO2_COMMIT_NOW
        );
    void GetFrequencyRatio(
        out float pRatio
        );
    HRESULT SetSourceSampleRate(
        uint NewSourceSampleRate
        );
}


interface IXAudio2SubmixVoice : IXAudio2Voice
{
extern(Windows):
}


interface IXAudio2MasteringVoice : IXAudio2Voice
{
extern(Windows):
version(DXSDK_11_1)
{
	HRESULT GetChannelMask(out uint ChannelMask);
}
}


interface IXAudio2EngineCallback : IUnknown
{
extern(Windows):
    void OnProcessingPassStart(
        );
    void OnProcessingPassEnd(
        );
    void OnCriticalError(
        HRESULT Error
        );
}


interface IXAudio2VoiceCallback : IUnknown
{
extern(Windows):
    void OnVoiceProcessingPassStart(
        uint BytesRequired
        );
    void OnVoiceProcessingPassEnd(
        );
    void OnStreamEnd(
        );
    void OnBufferStart(
        void* pBufferContext
        );
    void OnBufferEnd(
        void* pBufferContext
        );
    void OnLoopEnd(
        void* pBufferContext
        );
    void OnVoiceError(
        void* pBufferContext,
        HRESULT Error
        );
}


float XAudio2DecibelsToAmplitudeRatio(float Decibels)
{
    return powf(10.0f, Decibels / 20.0f);
}


float XAudio2AmplitudeRatioToDecibels(float Volume)
{
    if (Volume == 0)
    {
        return -(float.max);
    }
    return 20.0f * log10f(Volume);
}


float XAudio2SemitonesToFrequencyRatio(float Semitones)
{
    return powf(2.0f, Semitones / 12.0f);
}


float XAudio2FrequencyRatioToSemitones(float FrequencyRatio)
{
    return 39.86313713864835f * log10f(FrequencyRatio);
}


float XAudio2CutoffFrequencyToRadians(float CutoffFrequency, uint SampleRate)
{
    if (cast(uint)(CutoffFrequency * 6.0f) >= SampleRate)
    {
        return XAUDIO2_MAX_FILTER_FREQUENCY;
    }
    return 2.0f * sinf(PIf * CutoffFrequency / SampleRate);
}


float XAudio2RadiansToCutoffFrequency(float Radians, float SampleRate)
{
    return SampleRate * asinf(Radians / 2.0f) / PIf;
}


float XAudio2CutoffFrequencyToOnePoleCoefficient(float CutoffFrequency, uint SampleRate)
{
    if (cast(uint)CutoffFrequency >= SampleRate)
    {
        return XAUDIO2_MAX_FILTER_FREQUENCY;
    }
    return ( 1.0f - powf(1.0f - 2.0f * CutoffFrequency / SampleRate, 2.0f) );
}


version(DXSDK_11_0)
{
    mixin(DX_DECLARE_IID("XAudio2", "5A508685-A254-4FBA-9B82-9A24B00306AF"));
    mixin(DX_DECLARE_IID("XAudio2_Debug", "DB05EA35-0329-4D4B-A53A-6DEAD03D3852"));


	HRESULT XAudio2Create(
						  out IXAudio2 ppXAudio2,
						  uint Flags = 0,
						  XAUDIO2_PROCESSOR XAudio2Processor = XAUDIO2_WINDOWS_PROCESSOR_SPECIFIER.XAUDIO2_DEFAULT_PROCESSOR
							  )
	{
		IXAudio2 pXAudio2;

		HRESULT hr = CoCreateInstance((Flags & XAUDIO2_DEBUG_ENGINE) ? &IID_XAudio2_Debug : &IID_XAudio2,
									  null,
									  CLSCTX_INPROC_SERVER,
									  &IID_IXAudio2,
									  cast(void**)&pXAudio2);

		if (SUCCEEDED(hr))
		{
			hr = pXAudio2.Initialize(Flags, XAudio2Processor);

			if (SUCCEEDED(hr))
			{
				ppXAudio2 = pXAudio2;
			}
			else
			{
				pXAudio2.Release();
			}
		}

		return hr;
	}
}


version(DXSDK_11_1)
{

	HRESULT XAudio2Create(
						  out IXAudio2 ppXAudio2,
						  uint Flags = 0,
						  XAUDIO2_PROCESSOR XAudio2Processor = XAUDIO2_WINDOWS_PROCESSOR_SPECIFIER.XAUDIO2_DEFAULT_PROCESSOR
							  );
}
