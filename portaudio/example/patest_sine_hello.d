module patest_sine_hello;

/** @file patest_sine.c
	@ingroup test_src
	@brief Play a sine wave for several seconds.
	@author Ross Bencina <rossb@audiomulch.com>
    @author Phil Burk <philburk@softsynth.com>
    @author D conversion: Jonas Kivi <satelliittipupu@y????.co.uk>
*/
/*
 * $Id: patest_sine.c 1294 2007-10-24 20:51:22Z bjornroche $
 *
 * This program uses the PortAudio Portable Audio Library.
 * For more information see: http://www.portaudio.com/
 * Copyright (c) 1999-2000 Ross Bencina and Phil Burk
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files
 * (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 * The text above constitutes the entire PortAudio license; however, 
 * the PortAudio community also makes the following non-binding requests:
 *
 * Any person wishing to distribute modifications to the Software is
 * requested to send the modifications to the original developer so that
 * they can be incorporated into the canonical version. It is also 
 * requested that these non-binding requests be included along with the 
 * license above.
 */

import tango.io.Stdout;
import tango.math.Math;
version(nogc)
{
	import tango.core.Memory;
}

import portaudio.portaudio;

const NUM_SECONDS = 5;
const SAMPLE_RATE = 44100;
const FRAMES_PER_BUFFER = 64;//64;

const TABLE_SIZE = 200;

struct paTestData
{
    float[TABLE_SIZE] sine;
    int left_phase;
    int right_phase;
    char[20] message;
}


/* This routine will be called by the PortAudio engine when audio is needed.
** It may called at interrupt level on some machines so don't do anything
** that could mess up the system like calling malloc() or free().
*/

//inputBuffer was const
//PaStreamCallbackTimeInfo was const
//unsigned long . uint
extern (C)
static int patestCallback( void *inputBuffer, void *outputBuffer,
                            uint framesPerBuffer,
                            PaStreamCallbackTimeInfo* timeInfo,
                            PaStreamCallbackFlags statusFlags,
                            void *userData )
{
	//Stdout("PortAudio patestCallback.").newline;

    paTestData* data = cast(paTestData*)userData;
    float* toOut = cast(float*)outputBuffer;
    uint i;

    /*(void) timeInfo; // Prevent unused variable warnings.
    (void) statusFlags;
    (void) inputBuffer;*/
    
    for( i=0; i<framesPerBuffer; i++ )
    {
        *toOut++ = data.sine[data.left_phase];  /* left */
        *toOut++ = data.sine[data.right_phase];  /* right */
        data.left_phase += 1;
        if( data.left_phase >= TABLE_SIZE ) data.left_phase -= TABLE_SIZE;
        data.right_phase += 3; /* higher pitch so we can distinguish left and right. */
        if( data.right_phase >= TABLE_SIZE ) data.right_phase -= TABLE_SIZE;
    }
		
    return PaStreamCallbackResult.paContinue;
}


/*
 * This routine is called by portaudio when playback is done.
 */
extern (C)
static void StreamFinished( void* userData )
{
   paTestData *data = cast(paTestData *) userData;
   //Stdout( "Stream Completed: ")( data.message ).newline;
}

/*******************************************************************/

//int main(char[][] args)
int main()
{
	Stdout("PortAudio test.").newline;

	version(nogc)
	{
		GC.disable();
	}	
	

    PaStreamParameters outputParameters;
    PaStream *stream;
    PaError err;
    paTestData data;
    int i;

    
    Stdout("PortAudio Test: output sine wave. Sample rate: ")( SAMPLE_RATE)(" Buffer size: ")( FRAMES_PER_BUFFER).newline;
    
    /* initialise sinusoidal wavetable */
    for( i=0; i<TABLE_SIZE; i++ )
    {
        data.sine[i] = cast(float) sin( (cast(double)i/cast(double)TABLE_SIZE) * PI * 2.0 );
    }
    data.left_phase = data.right_phase = 0;
    
    err = Pa_Initialize();
    if( err != PaError.paNoError ) goto error;

    outputParameters.device = Pa_GetDefaultOutputDevice(); /* default output device */
    outputParameters.channelCount = 2;       /* stereo output */
    outputParameters.sampleFormat = paFloat32; /* 32 bit floating point output */
    outputParameters.suggestedLatency = Pa_GetDeviceInfo( outputParameters.device ).defaultLowOutputLatency;
    outputParameters.hostApiSpecificStreamInfo = null;

    err = Pa_OpenStream(
              &stream,
              null, /* no input */
              &outputParameters,
              SAMPLE_RATE,
              FRAMES_PER_BUFFER,
              paClipOff,      /* we won't output out of range samples so don't bother clipping them */
              cast(PaStreamCallback)&patestCallback,
              &data );
    if( err != PaError.paNoError ) goto error;

    //sprintf( data.message, "No Message" );
    err = Pa_SetStreamFinishedCallback( stream, cast(PaStreamFinishedCallback)&StreamFinished );
    //if( err != paNoError ) goto error;

    err = Pa_StartStream( stream );
    //if( err != paNoError ) goto error;

    Stdout("Play for seconds: ")( NUM_SECONDS ).newline;
    Pa_Sleep( NUM_SECONDS * 1000 );
    /*
    //You can exit the infinite_loop if you're in a command line with CTRL-C.
    int infinite_loop = 1;
    while( infinite_loop == 1 )
    {
    	//
    }*/

    err = Pa_StopStream( stream );
    //if( err != paNoError ) goto error;

    err = Pa_CloseStream( stream );
    //if( err != paNoError ) goto error;

    Pa_Terminate();
    Stdout("Test finished.\n").newline;
    
    version(nogc)
		{
			GC.enable();
		}
    
    return err;
error:
    Pa_Terminate();
    Stdout( "An error occured while using the portaudio stream\n" );
    Stdout( "Error number: ")( err );
    Stdout( "Error message: ")( Pa_GetErrorText( err ) ).newline;
    return err;
    
    
}
