/* Converted to D from quicktime.h by htod */
module lqt.quicktime;
/*******************************************************************************
 quicktime.h

 libquicktime - A library for reading and writing quicktime/avi/mp4 files.
 http://libquicktime.sourceforge.net

 Copyright (C) 2002 Heroine Virtual Ltd.
 Copyright (C) 2002-2007 Members of the libquicktime project.

 This library is free software; you can redistribute it and/or modify it under
 the terms of the GNU Lesser General Public License as published by the Free
 Software Foundation; either version 2.1 of the License, or (at your option)
 any later version.

 This library is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 details.

 You should have received a copy of the GNU Lesser General Public License along
 with this library; if not, write to the Free Software Foundation, Inc., 51
 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
*******************************************************************************/

//C     #ifndef QUICKTIME_H
//C     #define QUICKTIME_H

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif

//#include <inttypes.h>
//#include <stddef.h>

/* Some public enums needed by most subsequent headers */

/**
 * @file quicktime.h
 * Public api header for the quicktime4linux compatibility layer.
 */

/** \defgroup general General
    \brief General structures and functions
 */

/** \defgroup log Logging
    \brief Message handling
 */

  
/** \defgroup audio Audio
    \brief Audio related definitions and functions
 */

/** \defgroup audio_decode Audio decoding
 *  \ingroup audio
 *  \brief Audio related definitions and functions (reading)
 *
 * The audio API changed a lot during the last years (causing lot of confusion), so here is the
 * preferred way: First get the number of audio tracks with \ref quicktime_audio_tracks. Then
 * for each track you want to decode, use \ref quicktime_supported_audio to verify that a codec
 * is available. Then get the audio format with \ref quicktime_track_channels and \ref quicktime_sample_rate .
 * Then use \ref lqt_decode_audio_track to decode noninterleaved channels in either 16bit integer
 * or floating point [-1.0..1.0] format. This method will convert all internally used formats to the datatypes
 * you want, but won't output the full precision for 24/32 bit formats. If you want the samples as raw as possible
 * (bypassing all internal sample format conversions), use \ref lqt_get_sample_format to get the sampleformat
 * natively used by the codec and \ref lqt_decode_audio_raw to decode it.
 */

/** \defgroup audio_encode Audio encoding
 *  \ingroup audio
 *  \brief Audio related definitions and functions (writing)
 *
 * The audio API changed a lot during the last years (causing lot of confusion), so here is the
 * preferred way: Use the \ref codec_registry functions to get all supported audio encoders.
 * Once you found a codec (i.e. a \ref lqt_codec_info_t ), call \ref lqt_add_audio_track to
 * add the track to the file. You can repeat this procedure to add as many tracks as you like
 * with different formats and/or codecs.
 *
 * Next you might want to set some compression parameters. This is done by calling \ref lqt_set_audio_parameter.
 * Supported parameters and valid ranges are in the \ref lqt_codec_info_t.
 *
 * For each track, encode noninterleaved samples (either in 16bit integer
 * or floating point [-1.0..1.0] format) with \ref lqt_encode_audio_track . In this case, libquicktime
 * will convert your samples to the format used by the codec. This won't give the
 * full precision when using 24/32 bit formats. If you want to pass the samples as raw as possible
 * (bypassing all internal sample format conversions), use \ref lqt_get_sample_format to get the sampleformat
 * natively used by the codec and \ref lqt_encode_audio_raw to encode it.
 * 
 */

/** \defgroup multichannel Multichannel support
 *  \ingroup audio
 *
 * This is an optional API extension, which allows multichannel
 * configuration to be saved into a file. The mechanisms used are the
 * quicktime chan atom as well as some codec specific multichannel
 * setups.
 *
 *  When decoding, simply get the channel setup with \ref lqt_get_channel_setup.
 *  It can happen, that this function returns NULL when no specific mapping is known.
 *
 *  When encoding, things are more complicated. Some codecs have fixed channel
 *  setups. After setting up an audio track, call \ref lqt_get_channel_setup to
 *  check, if there is already a prefefined channel setup. If this is the case (i.e. if non
 *  NULL is returned), you MUST use this  channel setup.
 *
 *  If there is no predefined setup (i.e. \ref lqt_get_channel_setup returns NULL after
 *  creation of the audio track), call \ref lqt_set_channel_setup to set your desired
 *  setup. It can happen, that libquicktime will reorder the channel setup. Thus
 *  you need a final call to \ref lqt_get_channel_setup to know the whole truth.

*/

/** \ingroup log
 *  \brief Log level
 */

//C     typedef enum
//C       {
//C         LQT_LOG_ERROR   = (1<<0),
//C         LQT_LOG_WARNING = (1<<1),
//C         LQT_LOG_INFO    = (1<<2),
//C         LQT_LOG_DEBUG   = (1<<3),
//C       } lqt_log_level_t;
enum
{
    LQT_LOG_ERROR = 1,
    LQT_LOG_WARNING,
    LQT_LOG_INFO = 4,
    LQT_LOG_DEBUG = 8,
}
extern (C):
alias int lqt_log_level_t;

/** \ingroup log
 *  \brief Log callback
 *  \param level The log level
 *  \param domain Log domain (e.g. name of the module)
 *  \param message The message to pass
 *  \param data Application supplied data
 */

//C     typedef void (*lqt_log_callback_t)(lqt_log_level_t level,
//C                                        const char * domain,
//C                                        const char * message,
//C                                        void * data);
alias void  function(lqt_log_level_t level, char *domain, char *message, void *data)lqt_log_callback_t;

  
/** \ingroup General
 *  \brief File types
 *
 * These are bitmasks since codecs need lists of supported file formats
 */

//C     typedef enum
//C       {
//C         LQT_FILE_NONE = 0,        /*!< Undefined or not yet set */
//C         LQT_FILE_QT_OLD   = (1<<0), /*!< Old libquicktime format (without ftyp) */
//C         LQT_FILE_QT       = (1<<1), /*!< New libquicktime format (ftyp = "qt  ") */
//C         LQT_FILE_AVI      = (1<<2), /*!< AVI */
//C         LQT_FILE_AVI_ODML = (1<<3), /*!< Opendml AVI (> 2G) */
//C         LQT_FILE_MP4      = (1<<4), /*!< .mp4 (ftyp = "mp42") */
//C         LQT_FILE_M4A      = (1<<5), /*!< .m4a  */
//C         LQT_FILE_3GP      = (1<<6), /*!< .3gp  */
//C       } lqt_file_type_t;
enum
{
    LQT_FILE_NONE,
    LQT_FILE_QT_OLD,
    LQT_FILE_QT,
    LQT_FILE_AVI = 4,
    LQT_FILE_AVI_ODML = 8,
    LQT_FILE_MP4 = 16,
    LQT_FILE_M4A = 32,
    LQT_FILE_3GP = 64,
}
alias int lqt_file_type_t;

  
/** \ingroup multichannel
 *  \brief Channel definitions
 *
 *  These are the channel types defined in the public API. They should
 *  enable to support most channel configurations. Internally,
 *  many more channel types exist. They can be added to the public part
 *  on demand.
 *
 */

//C     typedef enum 
//C       {
//C         LQT_CHANNEL_UNKNOWN,
//C         LQT_CHANNEL_FRONT_LEFT,
//C         LQT_CHANNEL_FRONT_RIGHT,
//C         LQT_CHANNEL_FRONT_CENTER,
//C         LQT_CHANNEL_FRONT_CENTER_LEFT,
//C         LQT_CHANNEL_FRONT_CENTER_RIGHT,
//C         LQT_CHANNEL_BACK_CENTER,
//C         LQT_CHANNEL_BACK_LEFT,
//C         LQT_CHANNEL_BACK_RIGHT,
//C         LQT_CHANNEL_SIDE_LEFT,
//C         LQT_CHANNEL_SIDE_RIGHT,
//C         LQT_CHANNEL_LFE,
//C       } lqt_channel_t;
enum
{
    LQT_CHANNEL_UNKNOWN,
    LQT_CHANNEL_FRONT_LEFT,
    LQT_CHANNEL_FRONT_RIGHT,
    LQT_CHANNEL_FRONT_CENTER,
    LQT_CHANNEL_FRONT_CENTER_LEFT,
    LQT_CHANNEL_FRONT_CENTER_RIGHT,
    LQT_CHANNEL_BACK_CENTER,
    LQT_CHANNEL_BACK_LEFT,
    LQT_CHANNEL_BACK_RIGHT,
    LQT_CHANNEL_SIDE_LEFT,
    LQT_CHANNEL_SIDE_RIGHT,
    LQT_CHANNEL_LFE,
}
alias int lqt_channel_t;

  
/** \defgroup video Video
    \brief Video related definitions and functions
 */

/** \defgroup video_decode Video decoding
 * \ingroup video
 * \brief Video related definitions and functions (reading)
 *
 * The video API changed a lot during the last years (causing lot of confusion), so here is the
 * preferred way: First get the number of video tracks with \ref quicktime_video_tracks. Then
 * for each track you want to decode, use \ref quicktime_supported_video to verify that a codec
 * is available. Then for each track, get the frame size with \ref quicktime_video_width and
 * \ref quicktime_video_height . The framerate is only exact when handled as a rational number.
 * Thus, you'll need 2 functions \ref lqt_video_time_scale and \ref lqt_frame_duration .
 * The framerate in frames/sec becomes time_scale/frame_duration. Further format information can
 * be obtained with \ref lqt_get_pixel_aspect, \ref lqt_get_interlace_mode and \ref lqt_get_chroma_placement.
 *
 * A very important thing is the colormodel (see \ref color): First obtain the colormodel used natively
 * by the codec with \ref lqt_get_cmodel. Your application might or might not support all colormodels,
 * which exist in libquicktime. The more colormodels you can handle yourself, the better, since libquicktimes
 * built in colormodel converter is not the best. Thus, it's the best idea to pack all colormodels you
 * can handle yourself into an array, and call \ref lqt_get_best_colormodel to get the best colormodel. After you
 * figured out, which colormodel you use, tell this to libquicktime with \ref lqt_set_cmodel.
 *
 * When decoding frames, libquicktime by default assumes, that the frames you pass to it have no padding bytes
 * between the scanlines. Some APIs however padd scanlines to certain boundaries. If this is the case, you must
 * tell this to libquicktime by calling \ref lqt_set_row_span and \ref lqt_set_row_span_uv (for planar formats).
 *
 * Then, for each frame, it's wise to get the timestamp with \ref lqt_frame_time before decoding it. This will
 * make sure, that you'll support tracks with nonconstant framerates. The actual decoding then should happen with
 * \ref lqt_decode_video.
 */

/** \defgroup video_encode Video encoding
 *  \ingroup video
 *  \brief Video related definitions and functions (writing)
 *
 * The video API changed a lot during the last years (causing lot of confusion), so here is the
 * preferred way: Use the \ref codec_registry functions to get all supported video encoders.
 * Once you found a codec (i.e. a \ref lqt_codec_info_t ), call \ref lqt_add_video_track to
 * add the track to the file. You can repeat this procedure to add as many tracks as you like
 * with different formats and/or codecs. You can pass further format parameters with \ref lqt_set_pixel_aspect.
 *
 * A very important thing is the colormodel (see \ref color): First obtain the colormodel used natively
 * by the codec with \ref lqt_get_cmodel. Your application might or might not support all colormodels,
 * which exist in libquicktime. The more colormodels you can handle yourself, the better, since libquicktimes
 * built in colormodel converter is not the best. Thus, it's the best idea to pack all colormodels you
 * can handle yourself into an array, and call \ref lqt_get_best_colormodel to get the best colormodel. After you
 * figured out, which colormodel you use, tell this to libquicktime with \ref lqt_set_cmodel.
 *
 * Next you might want to set some compression parameters. This is done by calling \ref lqt_set_video_parameter.
 * Supported parameters and valid ranges are in the \ref lqt_codec_info_t.
 * 
 * Actual encoding should happen with \ref lqt_encode_video.
 */

/** \ingroup video
 * \brief interlace modes
 *
 * This is the interlace mode of a video track. Read it with
 * \ref lqt_get_interlace_mode .
 */
 
//C     typedef enum 
//C       {
//C         LQT_INTERLACE_NONE = 0, /*!< No interlacing (= progressive) */
//C         LQT_INTERLACE_TOP_FIRST, /*!< Top field first */
//C         LQT_INTERLACE_BOTTOM_FIRST  /*!< Bottom field first */
//C       } lqt_interlace_mode_t;
enum
{
    LQT_INTERLACE_NONE,
    LQT_INTERLACE_TOP_FIRST,
    LQT_INTERLACE_BOTTOM_FIRST,
}
alias int lqt_interlace_mode_t;

/** \ingroup video
 * \brief Chroma placement
 *
 * This describes the chroma placement of a video track. Read it with
 * \ref lqt_get_chroma_placement . Chroma placement makes only sense for
 * YUV420 formats. For other pixelformats, it is set implicitely to
 * LQT_CHROMA_PLACEMENT_DEFAULT.
 */
  
//C     typedef enum 
//C       {
//C         LQT_CHROMA_PLACEMENT_DEFAULT = 0, /*!< MPEG-1, JPEG or non 4:2:0 */
//C         LQT_CHROMA_PLACEMENT_MPEG2,       /*!< MPEG-2 */
//C         LQT_CHROMA_PLACEMENT_DVPAL,       /*!< DV PAL */
//C       } lqt_chroma_placement_t;
enum
{
    LQT_CHROMA_PLACEMENT_DEFAULT,
    LQT_CHROMA_PLACEMENT_MPEG2,
    LQT_CHROMA_PLACEMENT_DVPAL,
}
alias int lqt_chroma_placement_t;

/** \ingroup audio
 * \brief Sample format definitions for audio
 *
 * This defines the datatype for audio samples, which will be used by a
 * particular codec. You'll need this, if you want to use \ref lqt_decode_audio_raw
 * or \ref lqt_encode_audio_raw . Byte order of the data is always machine native.
 * Endianess conversion is responsibility of the codec.
 */
  
//C     typedef enum 
//C       {
//C         LQT_SAMPLE_UNDEFINED = 0, /*!< If this is returned, we have an error */
//C         LQT_SAMPLE_INT8,      /*!< int8_t */
//C         LQT_SAMPLE_UINT8,     /*!< unsigned char */
//C         LQT_SAMPLE_INT16,     /*!< short */
//C         LQT_SAMPLE_INT32,     /*!< long */
//C         LQT_SAMPLE_FLOAT      /*!< Float (machine native) */
//C       } lqt_sample_format_t;
enum
{
    LQT_SAMPLE_UNDEFINED,
    LQT_SAMPLE_INT8,
    LQT_SAMPLE_UINT8,
    LQT_SAMPLE_INT16,
    LQT_SAMPLE_INT32,
    LQT_SAMPLE_FLOAT,
}
alias int lqt_sample_format_t;
  
/** \ingroup general
    \brief Quicktime handle

    Opaque file handle used both for reading and writing. In quicktime4linux, this structure is
    public, resulting in programmers doing wrong things with it. In libquicktime, this is
    a private structure, which is accessed exclusively by functions.
 */
  
//C     typedef struct quicktime_s quicktime_t;
extern struct quicktime_s;
alias quicktime_s quicktime_t;
  
/* This is the reference for all your library entry points. */

/* ===== compression formats for which codecs exist ====== */

/** \defgroup video_codecs Video codec identifiers
 *  \brief Video codec identifiers
 *
 *  These definintions are for some more commonly used codecs.
 *  They can be used as the compressor argument for \ref quicktime_set_video .
 *  There is, however, no way to check, if a
 *  codec is accually present on the system.
 *  It should also be noted, that libquicktime supports more codecs, than
 *  are listed here. For these reasons, it's strongly recommended
 *  to use the more sophisticated codec selection mechanism via the
 *  \ref codec_registry .
 */

/** \ingroup video_codecs
 * \brief Non compatible divx
 *
 * Never hardcode this in an application!
 */

//C     #define QUICKTIME_DIVX "DIVX"

/** \ingroup video_codecs
 * \brief Divx for AVI files
 *
 * Never hardcode this in an application!
 */

//C     #define QUICKTIME_DIV3 "DIV3"

/** \ingroup video_codecs
 * \brief DV
 *
 * Never hardcode this in an application!
 */
  
//C     #define QUICKTIME_DV "dvc "
/* AVID DV codec can be processed with libdv as well */

/** \ingroup video_codecs
 * \brief DV
 *
 * Never hardcode this in an application!
 */

//C     #define QUICKTIME_DV_AVID "AVdv"

/** \ingroup video_codecs
 * \brief DV
 *
 * Never hardcode this in an application!
 */

//C     #define QUICKTIME_DV_AVID_A "dvcp"

/** \ingroup video_codecs
 * \brief Uncompressed RGB.
 *
 * Never hardcode this in an application. There are 2 encoders with
 * this fourcc, one for RGB and one for RGBA.
 */
  
/* RGB uncompressed.  Allows alpha */
//C     #define QUICKTIME_RAW  "raw "

/** \ingroup video_codecs
 * \brief JPEG-Photo
 *
 * Might be missing if libjpeg headers aren't there during compilation.
 */
  
/* Jpeg Photo */
//C     #define QUICKTIME_JPEG "jpeg"

/* Concatenated png images.  Allows alpha */

/** \ingroup video_codecs
 * \brief JPEG-Photo
 *
 * Might be missing if libjpeg headers aren't there during compilation.
 * There are 2 encoders, one for RGB, the other for RGBA.
 */

//C     #define QUICKTIME_PNG "png "

/** \ingroup video_codecs
 * \brief Motion JPEG-A
 *
 * Might be missing if libjpeg headers aren't there during compilation.
 * A good choice for high quality interlaced storage.
 */

//C     #define QUICKTIME_MJPA "mjpa"

/** \ingroup video_codecs
 * \brief 8 bit Packed full-range (not video) YUV 4:2:2
 *
 * Should always be there, can safely be hardcoded.
 */
  
//C     #define QUICKTIME_YUV2 "yuv2"

/** \ingroup video_codecs
 * \brief YUV 4:2:0
 *
 * Not compatible with standard quicktime.
 */
  
//C     #define QUICKTIME_YUV4 "yuv4"

/** \ingroup video_codecs
 * \brief 8 bit planar YUV 4:2:0
 *
 * Practically no external information about this codec exists. It should
 * always be available, but nevertheless not used.
 */
  
//C     #define QUICKTIME_YUV420  "yv12"

/** \ingroup video_codecs
 * \brief 8 bit Packed YUV (video range) 4:2:2
 *
 * Should always be there, can safely be hardcoded.
 */
  
//C     #define QUICKTIME_2VUY "2vuy"

/** \ingroup video_codecs
 * \brief 8 bit Packed YUV 4:4:4
 *
 * Should always be there, can safely be hardcoded.
 */
  
//C     #define QUICKTIME_V308  "v308"

/** \ingroup video_codecs
 * \brief 8 bit Packed YUVA 4:4:4:4
 *
 * Should always be there, can safely be hardcoded.
 */

//C     #define QUICKTIME_V408 "v408"

/** \ingroup video_codecs
 * \brief 10 bit Packed YUV 4:2:2
 *
 * Should always be there, can safely be hardcoded.
 */
  
//C     #define QUICKTIME_V210 "v210"

/** \ingroup video_codecs
 * \brief 10 bit Packed YUV 4:4:4
 *
 * Should always be there, can safely be hardcoded.
 */

//C     #define QUICKTIME_V410 "v410"

/* =================== Audio formats ======================= */

/** \defgroup audio_codecs Audio codec identifiers
 *  \brief Audio codec identifiers
 *
 *  These definintions are for some more commonly used codecs.
 *  They can be used as the compressor argument for \ref quicktime_set_audio .
 *  There is, however, no way to check, if a
 *  codec is accually present on the system.
 *  It should also be noted, that libquicktime supports more codecs, than
 *  are listed here. For these reasons, it's strongly recommended
 *  to use the more sophisticated codec selection mechanism via the
 *  \ref codec_registry .
 */

/** \ingroup audio_codecs
 * \brief Unsigned 8 bit
 *
 * Should always be there, can safely be hardcoded.
 */
 
//C     #define QUICKTIME_RAWAUDIO "raw "

/** \ingroup audio_codecs
 * \brief IMA4
 *
 * Should always be there, can safely be hardcoded.
 */

//C     #define QUICKTIME_IMA4 "ima4"

/** \ingroup audio_codecs
 * \brief Twos compliment 16 bit
 *
 * Should always be there, can safely be hardcoded.
 */
  
//C     #define QUICKTIME_TWOS "twos"

/** \ingroup audio_codecs
 * \brief mu-law 2:1
 *
 * Should always be there, can safely be hardcoded.
 */
  
//C     #define QUICKTIME_ULAW "ulaw"

/** \ingroup audio_codecs
 * \brief Ogg Vorbis
 *
 *  This depends on libvorbis and creates incompatible streams,
 *  which won't play anywhere except libquicktime and perhaps
 *  quicktime4linux. Never hardcode this.
 */

//C     #define QUICKTIME_VORBIS "OggS"

/** \ingroup audio_codecs
 * \brief MP3
 *
 *  This depends on lame, which might or might not be there.
 *  Never hardcode this.
 */

//C     #define QUICKTIME_MP3 ".mp3"
  
/* =========================== public interface ========================= // */

/** \ingroup general
 *  \brief Get the quicktime4linux major version
 *
 * This returns the major quicktime4linux version. The complete version is 2.0.0, which
 * was the last qt4l version from which we ported code. It's not usable for detecting the
 * libquicktime version.
 */
  
  /* Get version information */
//C     int quicktime_major();
int  quicktime_major();//...);

/** \ingroup general
 *  \brief Get the quicktime4linux minor version
 *
 * This returns the minor quicktime4linux version. The complete version is 2.0.0, which
 * was the last qt4l version from which we ported code. It's not usable for detecting the
 * libquicktime version.
 */
//C     int quicktime_minor();
int  quicktime_minor();//...);

/** \ingroup general
 *  \brief Get the quicktime4linux release number
 *
 * This returns the release number of quicktime4linux. The complete version is 2.0.0, which
 * was the last qt4l version from which we ported code. It's not usable for detecting the
 * libquicktime version.
 */

//C     int quicktime_release();
int  quicktime_release();//...);

/** \ingroup general
    \brief Test file compatibility
    \param path A path to a regular file
    \returns 1 if the file is decodable by libquicktime.
    
    Check the signature of a path and return 1 is the file is likely to ba
    decodable by libquicktime. This check might return false positives or false
    negatives. In general it's better (although slower) to check, if \ref quicktime_open
    return NULL or not.
 */
  
//C     int quicktime_check_sig(char *path);
int  quicktime_check_sig(char *path);

/** \ingroup general
    \brief Open a file
    \param filename A path to a regular file
    \param rd 1 for open readonly, 0 else
    \param wr 1 for open writeonly, 0 else
    \returns An initialized file handle or NULL if opening failed.
    
    Note, that files can never be opened read/write mode.
*/
  
//C     quicktime_t* quicktime_open(const char *filename, int rd, int wr);
quicktime_t * quicktime_open(char *filename, int rd, int wr);

/** \ingroup general
    \brief Make a file streamable 
    \param in_path Existing non streamable file
    \param out_path Output file
    \returns 1 if an error occurred, 0 else

    This function makes a file streamable by placing the moov header at the beginning of the file.
    Note that you need approximately the twice the disk-space of the file. It is recommended, that
    this function is called only for files, which are encoded by libquicktime. Other files might not
    be correctly written.
*/
  
//C     int quicktime_make_streamable(char *in_path, char *out_path);
int  quicktime_make_streamable(char *in_path, char *out_path);

/** \defgroup metadata Metadata support
    \brief Metadata support

    These functions allow you to read/write the metadata of the file. Currently, only the
    metadata in the udta atom are supported.
*/

/** \ingroup metadata
    \brief Set the copyright info for the file
    \param file A quicktime handle
    \param string The copyright info
*/
  
//C     void quicktime_set_copyright(quicktime_t *file, char *string);
void  quicktime_set_copyright(quicktime_t *file, char *string);

/** \ingroup metadata
    \brief Set the name for the file
    \param file A quicktime handle
    \param string The name
*/

//C     void quicktime_set_name(quicktime_t *file, char *string);
void  quicktime_set_name(quicktime_t *file, char *string);

/** \ingroup metadata
    \brief Set info for the file
    \param file A quicktime handle
    \param string An info string
*/

//C     void quicktime_set_info(quicktime_t *file, char *string);
void  quicktime_set_info(quicktime_t *file, char *string);

/** \ingroup metadata
    \brief Get the copyright info from the file
    \param file A quicktime handle
    \returns The copyright info or NULL
*/
  

//C     char* quicktime_get_copyright(quicktime_t *file);
char * quicktime_get_copyright(quicktime_t *file);

/** \ingroup metadata
    \brief Get the name from the file
    \param file A quicktime handle
    \returns The name or NULL
*/
  

//C     char* quicktime_get_name(quicktime_t *file);
char * quicktime_get_name(quicktime_t *file);

/** \ingroup metadata
    \brief Get the info string from the file
    \param file A quicktime handle
    \returns The info string or NULL
*/
  
//C     char* quicktime_get_info(quicktime_t *file);
char * quicktime_get_info(quicktime_t *file);


/** \ingroup audio_encode
    \brief Set up tracks in a new file after opening and before writing
    \param file A quicktime handle
    \param channels Number of channels
    \param sample_rate Samplerate
    \param bits Bits per sample
    \param compressor Compressor to use

    Returns the number of quicktime tracks allocated. Audio is stored two channels
    per quicktime track.

    This function is depracated and should not be used in newly written code. It won't let you
    add individual tracks with different codecs, samplerates etc. Use \ref lqt_add_audio_track instread.
*/
  
//C     int quicktime_set_audio(quicktime_t *file, 
//C     	int channels, 
//C     	long sample_rate, 
//C     	int bits, 
//C     	char *compressor);
int  quicktime_set_audio(quicktime_t *file, int channels, int sample_rate, int bits, char *compressor);

/** \ingroup video_encode
    \brief Set the framerate for encoding
    \param file A quicktime handle
    \param framerate framerate

    Sets the framerate for encoding.

    This function is depracated and should not be used in newly written code.
*/

//C     void quicktime_set_framerate(quicktime_t *file, double framerate);
void  quicktime_set_framerate(quicktime_t *file, double framerate);

/** \ingroup video_encode
    \brief Set up video tracks for encoding
    \param file A quicktime handle
    \param tracks Number of tracks
    \param frame_w Frame width
    \param frame_h Frame height
    \param frame_rate Frame rate (in frames per second)
    \param compressor Four character code of the compressor

    This function is depracated and should not be used in newly written code.
    It won't allow you to set multiple video streams with different formats,
    and passing a double framerate causes rounding errors.
    Use \ref lqt_add_video_track instead.
*/
  
//C     int quicktime_set_video(quicktime_t *file, 
//C     	int tracks, 
//C     	int frame_w, 
//C     	int frame_h, 
//C     	double frame_rate, 
//C     	char *compressor);
int  quicktime_set_video(quicktime_t *file, int tracks, int frame_w, int frame_h, double frame_rate, char *compressor);

/** \ingroup video_encode
    \brief Set jpeg encoding quality
    \param file A quicktime handle
    \param quality Quality (0..100)
    \param use_float Use floating point routines
    
    Set the jpeg encoding quality and whether to use floating point routines.
    This should be called after creating the video track(s).
    
    This function is depracated and should not be used in newly written code.
    Use \ref lqt_set_video_parameter instead.
*/
  
//C     void quicktime_set_jpeg(quicktime_t *file, int quality, int use_float);
void  quicktime_set_jpeg(quicktime_t *file, int quality, int use_float);

/** \ingroup video_encode
 * \brief Set a codec parameter
 *  \param file A quicktime handle
 *  \param key Short name of the parameter
 *  \param value Parameter value.
 *
 *  For integer parameters, value must be of the type int*. For string parameters,
 *  use char*.
 *
 *  This function sets the same parameter for all video AND audio streams, which is quite
 *  idiotic. Use \ref lqt_set_audio_parameter and \ref lqt_set_video_parameter to set
 *  codec parameters on a per stream basis.
 */

//C     void quicktime_set_parameter(quicktime_t *file, char *key, void *value);
void  quicktime_set_parameter(quicktime_t *file, char *key, void *value);

/** \ingroup video_encode
 *  \brief Set the depth of a video track.
 *  \param file A quicktime handle
 *  \param depth The depth (bits per pixel)
 *  \param track index (starting with 0)
 *
 *  This function is deprecated and should never be called.
 *  The depth is set by the codecs and there is no reason to change this.
 *  
 */
//C     void quicktime_set_depth(quicktime_t *file, 
//C     	int depth, 
//C     	int track);
void  quicktime_set_depth(quicktime_t *file, int depth, int track);

/** \ingroup video
 * \brief Set the colormodel for en-/decoding
 * \param file A quicktime handle
 * \param colormodel The colormodel to use.
 *
 * This sets the colormodels for all video tracks at once.
 * It's a better idea to use \ref lqt_set_cmodel instead.
 */

//C     void quicktime_set_cmodel(quicktime_t *file, int colormodel);
void  quicktime_set_cmodel(quicktime_t *file, int colormodel);

/** \ingroup video
 * \brief Set the row_span for en-/decoding
 * \param file A quicktime handle
 * \param row_span The rowspan to use.
 *
 * This sets the rowspans for all video tracks at once.
 * It's a better idea to use \ref lqt_set_row_span and
 * \ref lqt_set_row_span_uv instead.
 */

//C     void quicktime_set_row_span(quicktime_t *file, int row_span);
void  quicktime_set_row_span(quicktime_t *file, int row_span);

/** \ingroup general
 * \brief Close a quicktime handle and free all associated memory
 * \param file A quicktime handle
 */
  
//C     int quicktime_close(quicktime_t *file);
int  quicktime_close(quicktime_t *file);

/* get.size information */
/* channel numbers start on 1 for audio and video */

/** \ingroup audio_decode
 *  \brief Get the audio.size
 *  \param file A quicktime handle
 *  \param track index (starting with 0)
 *  \returns The total number of uncompressed audio samples in the track
 */
    

//C     long quicktime_audio_length(quicktime_t *file, int track);
int  quicktime_audio_length(quicktime_t *file, int track);

/** \ingroup video_decode
 *  \brief Get the video.size
 *  \param file A quicktime handle
 *  \param track index (starting with 0)
 *  \returns The total number of video frames in the track
 *
 * Note that for tracks with nonconstant framerate, you won't be able to obtain the
 * track duration from the number of frame. If you are interested in the total playing time,
 * use \ref lqt_video_duration
 */

//C     long quicktime_video_length(quicktime_t *file, int track);
int  quicktime_video_length(quicktime_t *file, int track);

/** \ingroup audio_decode
 *  \brief Get the audio position
 *  \param file A quicktime handle
 *  \param track index (starting with 0)
 *  \returns The number (starting with 0) of the next sample to be decoded.
 */

  /* get position information */
//C     long quicktime_audio_position(quicktime_t *file, int track);
int  quicktime_audio_position(quicktime_t *file, int track);

/** \ingroup video_decode
 *  \brief Get the video position
 *  \param file A quicktime handle
 *  \param track index (starting with 0)
 *  \returns The number (starting with 0) of the next frame to be decoded.
 *
 *  To get timestamps for tracks with nonconstant framerate, use \ref lqt_frame_time
 */

//C     long quicktime_video_position(quicktime_t *file, int track);
int  quicktime_video_position(quicktime_t *file, int track);

/** \ingroup video_decode
 * \brief Get the number of video tracks
 * \param file A quicktime handle
 * \returns The number of video tracks
 */
  
/* get file information */
//C     int quicktime_video_tracks(quicktime_t *file);
int  quicktime_video_tracks(quicktime_t *file);

/** \ingroup audio_decode
 * \brief Get the number of audio tracks
 * \param file A quicktime handle
 * \returns The number of audio tracks
 */

//C     int quicktime_audio_tracks(quicktime_t *file);
int  quicktime_audio_tracks(quicktime_t *file);

/** \ingroup audio_decode
 * \brief Check if a file has at least one audio track
 * \param file A quicktime handle
 * \returns 1 if the file has audio tracks, 0 else
 */
  
//C     int quicktime_has_audio(quicktime_t *file);
int  quicktime_has_audio(quicktime_t *file);

/** \ingroup audio_decode
 * \brief Get the samplerate of an audio track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The samplerate in Hz
 */

//C     long quicktime_sample_rate(quicktime_t *file, int track);
int  quicktime_sample_rate(quicktime_t *file, int track);

/** \ingroup audio_decode
 * \brief Get the bits per sample of an audio track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The bits per sample (typically 16)
 *
 * Don't use this function for anything else than for informational
 * purposes. Bits per sample is meaningless for compressed codecs, and
 * sometimes plain wrong even for uncompressed ones.
 *
 * To get some better informations about the resolution, a codec will
 * deliver, use \ref lqt_get_sample_format
 */

//C     int quicktime_audio_bits(quicktime_t *file, int track);
int  quicktime_audio_bits(quicktime_t *file, int track);

/** \ingroup audio_decode
 * \brief Get the number of channels of an audio track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The the number of channels
 */

//C     int quicktime_track_channels(quicktime_t *file, int track);
int  quicktime_track_channels(quicktime_t *file, int track);

/** \ingroup audio_decode
 * \brief Get the four character code of an audio track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The four character code (fourcc) of the track.
 *
 * Note, that this function might return nothing meaningful for AVI files,
 * since AVI doesn't use four character codes for audio streams.
 * To get more save information about the codec responsible for the stream,
 * use \ref lqt_audio_codec_from_file .
 */

//C     char* quicktime_audio_compressor(quicktime_t *file, int track);
char * quicktime_audio_compressor(quicktime_t *file, int track);

/** \ingroup video_decode
 * \brief Check if a file has at least one video track
 * \param file A quicktime handle
 * \returns 1 if the file has video tracks, 0 else
 */

//C     int quicktime_has_video(quicktime_t *file);
int  quicktime_has_video(quicktime_t *file);

/** \ingroup video_decode
 * \brief Get the width of a video track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The image width in pixels
 */

//C     int quicktime_video_width(quicktime_t *file, int track);
int  quicktime_video_width(quicktime_t *file, int track);

/** \ingroup video_decode
 * \brief Get the height of a video track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The image height in pixels
 */

//C     int quicktime_video_height(quicktime_t *file, int track);
int  quicktime_video_height(quicktime_t *file, int track);

/** \ingroup video_decode
 * \brief Get the depth of a video track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The image depth in pixels
 *
 * Don't use this function for anything else than for informational
 * purposes. Depth is meaningless for compressed codecs and
 * sometimes plain wrong even for uncompressed ones.
 *
 * To get some better informations about the pixel format, a codec will
 * deliver, use \ref lqt_get_cmodel or (better) \ref lqt_get_decoder_colormodel .
 * 
 */
//C     int quicktime_video_depth(quicktime_t *file, int track);
int  quicktime_video_depth(quicktime_t *file, int track);

/** \ingroup video_decode
 * \brief Get the framerate of a video track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The framerate in frames per second.
 *
 * Don't use this unless A/V sync is nor important. The return value is practically
 * random for tracks with nonconstant framerate. Even for constant framerate, the return
 * value can never correctly resemble e.g. the NTSC framerate (30000/1001).
 *
 * To get the framerate as a rational number (and check if it's constant), use \ref lqt_frame_duration
 * and \ref lqt_video_time_scale .
 */
  
//C     double quicktime_frame_rate(quicktime_t *file, int track);
double  quicktime_frame_rate(quicktime_t *file, int track);

/** \ingroup video_decode
 * \brief Get the four character code of a video track
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns The four character code (fourcc) of the track.
 *
 * To get more save information about the codec responsible for the stream,
 * use \ref lqt_video_codec_from_file .
 */

//C     char* quicktime_video_compressor(quicktime_t *file, int track);
char * quicktime_video_compressor(quicktime_t *file, int track);

/* number of bytes of raw data in this frame */

/** \ingroup video_decode
 * \brief Get the compressed size of frame in a video track
 * \param file A quicktime handle
 * \param frame Frame index (starting with 0)
 * \param track index (starting with 0)
 * \returns The size in bytes of the frame
 *
 * Use this if you want to read compressed frames with \ref quicktime_read_frame
 */
 

//C     long quicktime_frame_size(quicktime_t *file, long frame, int track);
int  quicktime_frame_size(quicktime_t *file, int frame, int track);

/** \ingroup audio_decode
 *  \param file A quicktime handle
 *  \param quicktime_track Returns the index of the quicktime track
 *  \param quicktime_channel Returns the channel index inside the quicktime track
 *  \param channel The channel to query
 *
 * Don't use this function (see \ref lqt_decode_audio )
 */
  
//C     int quicktime_channel_location(quicktime_t *file, int *quicktime_track, int *quicktime_channel, int channel);
int  quicktime_channel_location(quicktime_t *file, int *quicktime_track, int *quicktime_channel, int channel);

/* file positioning */
/* Remove these and see what happens :) */

// int quicktime_seek_end(quicktime_t *file);

/** \ingroup General
 *  \brief Reposition all tracks to the very beginning
 *  \param file A quicktime handle
 *  \returns Always 0
 *
 * Works (of course) only for decoding
 */

//C     int quicktime_seek_start(quicktime_t *file);
int  quicktime_seek_start(quicktime_t *file);

/* set position of file descriptor relative to a track */

/** \ingroup audio_decode
 *  \brief Seek to a specific audio position
 * \param file A quicktime handle
 * \param sample The sample position (starting with 0)
 * \param track index (starting with 0)
 *
 * Use this for seeking. During sequential decode calls, the position will be updated automatically
 */
//C     int quicktime_set_audio_position(quicktime_t *file, long long sample, int track);
int  quicktime_set_audio_position(quicktime_t *file, long sample, int track);

/** \ingroup video_decode
 *  \brief Seek to a specific video frame
 * \param file A quicktime handle
 * \param frame The frame position (starting with 0)
 * \param track index (starting with 0)
 *
 * Use this for seeking. During sequential decode calls, the position will be updated automatically.
 * If you want to support tracks with nonconmstant framerate, you should use \ref lqt_seek_video .
 */

//C     int quicktime_set_video_position(quicktime_t *file, long long frame, int track);
int  quicktime_set_video_position(quicktime_t *file, long frame, int track);

/* set window data */
//C     void quicktime_set_window(quicktime_t *file, int in_x, int in_y, int in_w, int in_h, int out_w, int out_h);
void  quicktime_set_window(quicktime_t *file, int in_x, int in_y, int in_w, int in_h, int out_w, int out_h);

/* ========================== Access to raw data follows. */
/* write data for one quicktime track */
/* the user must handle conversion to the channels in this track */
//C     int quicktime_write_audio(quicktime_t *file, unsigned char *audio_buffer, long samples, int track);
int  quicktime_write_audio(quicktime_t *file, ubyte *audio_buffer, int samples, int track);

/** \ingroup video_encode
 *  \brief Write a compressed video frame
 *  \param file A quicktime handle
 *  \param video_buffer The compressed frame
 *  \param bytes Bytes of the compressed frame
 *  \param track index (starting with 0)
 *
 *  If you get compressed video frames (e.g. from a firewire port),
 *  use this function to write them into a quicktime container. Before,
 *  you must set up the track with \ref lqt_add_video_track or, if no
 *  software codec is present, with \ref quicktime_set_video .
 */
     

//C     int quicktime_write_frame(quicktime_t *file, unsigned char *video_buffer, long long bytes, int track);
int  quicktime_write_frame(quicktime_t *file, ubyte *video_buffer, long bytes, int track);

/** \ingroup video_decode
 *  \brief Read a compressed video frame
 *  \param file A quicktime handle
 *  \param video_buffer The compressed frame
 *  \param track index (starting with 0)
 *
 *  Read a compressed video frame. The size of the frame can be obtained with
 *  \ref quicktime_frame_size . This function increments all pointers in the
 *  track, so you can sequentially read all frames without setting the position
 *  in between.
 */
  
//C     long quicktime_read_frame(quicktime_t *file, unsigned char *video_buffer, int track);
int  quicktime_read_frame(quicktime_t *file, ubyte *video_buffer, int track);

/* for reading frame using a library that needs a file descriptor */
/* Frame caching doesn't work here. */
//C     int quicktime_read_frame_init(quicktime_t *file, int track);
int  quicktime_read_frame_init(quicktime_t *file, int track);
//C     int quicktime_read_frame_end(quicktime_t *file, int track);
int  quicktime_read_frame_end(quicktime_t *file, int track);

/* One keyframe table for each track */
//C     long quicktime_get_keyframe_before(quicktime_t *file, long frame, int track);
int  quicktime_get_keyframe_before(quicktime_t *file, int frame, int track);
//C     void quicktime_insert_keyframe(quicktime_t *file, long frame, int track);
void  quicktime_insert_keyframe(quicktime_t *file, int frame, int track);
/* Track has keyframes */
//C     int quicktime_has_keyframes(quicktime_t *file, int track);
int  quicktime_has_keyframes(quicktime_t *file, int track);

/* ===================== Access to built in codecs follows. */

/* If the codec for this track is supported in the library return 1. */

/** \ingroup video_decode
 * \brief Check if a video track is supported by libquicktime
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns 1 if a codec for this track is available, 0 else
 */

//C     int quicktime_supported_video(quicktime_t *file, int track);
int  quicktime_supported_video(quicktime_t *file, int track);

/** \ingroup audio_decode
 * \brief Check if an audio track is supported by libquicktime
 * \param file A quicktime handle
 * \param track index (starting with 0)
 * \returns 1 if a codec for this track is available, 0 else
 */

//C     int quicktime_supported_audio(quicktime_t *file, int track);
int  quicktime_supported_audio(quicktime_t *file, int track);

/** \ingroup video_decode
 * \brief Check if a colormodel is supported for decoding
 * \param file A quicktime handle
 * \param colormodel A colormodel (see \ref color)
 * \param track index (starting with 0)
 * \returns 1 if the colormodel can be used for decoding calls, 0 if it can't.
 *
 * To let libquicktime get the best colormodel out of a list of colormodels your application
 * supports, use \ref lqt_get_best_colormodel instead.
 */
  
//C     int quicktime_reads_cmodel(quicktime_t *file, 
//C     		int colormodel, 
//C     		int track);
int  quicktime_reads_cmodel(quicktime_t *file, int colormodel, int track);

/** \ingroup video_encode
 * \brief Check if a colormodel is supported for encoding
 * \param file A quicktime handle
 * \param colormodel A colormodel (see \ref color)
 * \param track index (starting with 0)
 * \returns 1 if the colormodel can be used for encoding calls, 0 if it can't.
 *
 * To let libquicktime get the best colormodel out of a list of colormodels your application
 * supports, use \ref lqt_get_best_colormodel instead.
 */

//C     int quicktime_writes_cmodel(quicktime_t *file, 
//C     		int colormodel, 
//C     		int track);
int  quicktime_writes_cmodel(quicktime_t *file, int colormodel, int track);


/* Hacks for temporal codec */
//C     int quicktime_divx_is_key(unsigned char *data, long size);
int  quicktime_divx_is_key(ubyte *data, int size);
//C     int quicktime_divx_write_vol(unsigned char *data_start,
//C     	int vol_width, 
//C     	int vol_height, 
//C     	int time_increment_resolution, 
//C     	double frame_rate);
int  quicktime_divx_write_vol(ubyte *data_start, int vol_width, int vol_height, int time_increment_resolution, double frame_rate);
//C     int quicktime_divx_has_vol(unsigned char *data);
int  quicktime_divx_has_vol(ubyte *data);

//C     int quicktime_div3_is_key(unsigned char *data, long size);
int  quicktime_div3_is_key(ubyte *data, int size);

/** \ingroup video_encode
 * \brief Encode a video frame
 * \param file A quicktime handle
 * \param row_pointers Frame buffer (see \ref lqt_rows_alloc )
 * \param track index (starting with 0)
 *
 * Encode one video frame. This works only for constant framerate streams. For nonconstant framerates,
 * you'll want to use \ref lqt_encode_video instead.
 */
  
//C     int quicktime_encode_video(quicktime_t *file, 
//C     	unsigned char **row_pointers, 
//C     	int track);
int  quicktime_encode_video(quicktime_t *file, ubyte **row_pointers, int track);

/** \ingroup video_decode
 * \brief Decode a video frame in \ref BC_RGB888
 * \param file A quicktime handle
 * \param row_pointers Frame buffer (see \ref lqt_rows_alloc )
 * \param track index (starting with 0)
 *
 * Decode one video frame. All colormodels are converted to \ref BC_RGB888 automatically probably
 * causing lots of overhead. To decode frames in other colormodels, use \ref lqt_decode_video .
 */

//C     int quicktime_decode_video(quicktime_t *file, 
//C     	unsigned char **row_pointers, 
//C     	int track);
int  quicktime_decode_video(quicktime_t *file, ubyte **row_pointers, int track);

/** \ingroup video_decode
 * \brief Decode aand optionally scale a video frame
 * \param file A quicktime handle
 * \param in_x Horizontal offset of the image relative to the source image
 * \param in_y Vertical offset of the image relative to the source image
 * \param in_w Image width in the source image
 * \param in_h Image height in the source image
 * \param out_w Width of output frame
 * \param out_h Height of output frame
 * \param color_model Colormodel of the output frame
 * \param row_pointers Frame buffer (see \ref lqt_rows_alloc )
 * \param track index (starting with 0)
 *
 * This function takes a subwindow of the source image (specified by in_x, in_y, in_w, in_h)
 * and scales it to the dimensions (out_w, out_h) of the output frame given by row_pointers. Colormodel
 * conversion from the stream colormodel to the color_model you pass is also done. Scaling is done
 * by a not very optimized nearest neighbor algorithm. To do high quality video scaling, you should use
 * something else.
 */

//C     long quicktime_decode_scaled(quicktime_t *file, 
//C     	int in_x,                    /* Location of input frame to take picture */
//C     	int in_y,
//C     	int in_w,
//C     	int in_h,
//C     	int out_w,                   /* Dimensions of output frame */
//C     	int out_h,
//C     	int color_model,             /* One of the color models defined above */
//C     	unsigned char **row_pointers, 
//C     	int track);
int  quicktime_decode_scaled(quicktime_t *file, int in_x, int in_y, int in_w, int in_h, int out_w, int out_h, int color_model, ubyte **row_pointers, int track);

/* Decode or encode audio for a single channel into the buffer. */
/* Pass a buffer for the _i or the _f argument if you want int16 or float data. */
/* Notice that encoding requires an array of pointers to each channel. */

/** \ingroup audio_decode
 *  \brief Decode a number of audio samples of a single channel
 *  \param file A quicktime handle
 *  \param output_i 16 bit integer output buffer (or NULL)
 *  \param output_f floating point output buffer (or NULL)
 *  \param samples Number of samples to decode
 *  \param channel Channel to decode
 *
 * Never use this function: Decoding only one channel at once causes lots of internal overhead
 * if you need all channels anyway. In this case, \ref lqt_decode_audio_track is the better choice.
 * Furthermore, you won't be able to decode the full resolution
 * for 24 and 32 bit codecs. To decode the maximum resolution, use \ref lqt_decode_audio_raw.
 *
 * The number of actually decoded samples (and EOF) can be obtained with
 * \ref lqt_last_audio_position
 */
 
//C     int quicktime_decode_audio(quicktime_t *file, short *output_i, float *output_f, long samples, int channel);
int  quicktime_decode_audio(quicktime_t *file, short *output_i, float *output_f, int samples, int channel);

/** \ingroup audio_encode
 *  \brief Encode a number of audio samples for the first track
 *  \param file A quicktime handle
 *  \param input_i 16 bit integer output buffer (or NULL)
 *  \param input_f floating point output buffer (or NULL)
 *  \param samples Number of samples to decode
 *
 * Never use this function: It won't let you encode more than one audio track. To encode
 * audio for multiple tracks, use \ref lqt_encode_audio_track . If you want to pass the full
 * resolution even for 24/32 bit audio, use \ref lqt_encode_audio_raw .
 */

//C     int quicktime_encode_audio(quicktime_t *file, short **input_i, float **input_f, long samples);
int  quicktime_encode_audio(quicktime_t *file, short **input_i, float **input_f, int samples);

/** \ingroup general
 *  \brief Dump the file structures to stdout
 *  \param file A quicktime handle
 *
 * This is used for debugging or by the qtdump utility
 */
   
//C     int quicktime_dump(quicktime_t *file);
int  quicktime_dump(quicktime_t *file);

/* Specify the number of cpus to utilize. */

/** \ingroup general
 *  \brief Set the number of CPUs
 *  \param file A quicktime handle
 *  \param cpus Number of CPUs to use
 *
 *  Libquicktime no longer does multithreaded en-/decoding. Therefore you
 *  can call this function if you like, but it will have no effect :)
 */
  

//C     int quicktime_set_cpus(quicktime_t *file, int cpus);
int  quicktime_set_cpus(quicktime_t *file, int cpus);

/* Specify whether to read contiguously or not. */
/* preload is the number of bytes to read ahead. */
/* This is no longer functional to the end user but is used to accelerate */
/* reading the header internally. */
//C     void quicktime_set_preload(quicktime_t *file, long long preload);
void  quicktime_set_preload(quicktime_t *file, long preload);

//C     long long quicktime_byte_position(quicktime_t *file);
long  quicktime_byte_position(quicktime_t *file);

/** \ingroup general
 *  \brief Write an AVI file instead of quicktime
 *  \param file A quicktime handle
 *  \param value Set this to 1. If you want quicktime, simply don't call this function.
 *
 * This function must be called AFTER all tracks are set up and BEFORE anything is encoded.
 */
  
//C     void quicktime_set_avi(quicktime_t *file, int value);
void  quicktime_set_avi(quicktime_t *file, int value);

  

//C     #ifdef __cplusplus
//C     }
//C     #endif

//C     #endif
