//metro example from jack examples

/*
	The licence for the C version.
	(Also applies to the D one. I personally would never put
	the GPL licence on a simple tutorial, but you can always
	say that you didn't copy paste it, you just learned it.)

    Copyright (C) 2002 Anthony Van Groningen
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

module metro;

//import tango.io.FilePath;

//import Path = tango.io.Path;

import tango.util.log.Trace;

import Math = tango.math.Math;

import tango.stdc.string;//memcpy
import stringz = tango.stdc.stringz;

import jack.jack;
import jack.types;
import jack.transport;

import memory;


//It is advised in the Jack headers that you can make
//this sample_t alias to simplify writing it.
alias jack_default_audio_sample_t sample_t;

const double PI = 3.14;//How accurate is that?

//Lots of globals here.

jack_client_t *client;
jack_port_t *output_port;
ulong sr;
int freq = 100;
int bpm = 65;
jack_nframes_t tone_length, wave_length;
sample_t[] wave;
long offset = 0;
int transport_aware = 0;
jack_transport_state_t transport_state;

//You'll have to make your jack callbacks extern C.
extern (C)
void
process_silence (jack_nframes_t nframes) 
{
	sample_t *buffer = cast(sample_t *) jack_port_get_buffer (output_port, nframes);
	memset (buffer, 0,  jack_default_audio_sample_t.sizeof * nframes);
}

extern (C)
void
process_audio (jack_nframes_t nframes) 
{

	sample_t *buffer = cast(sample_t *) jack_port_get_buffer (output_port, nframes);
	jack_nframes_t frames_left = nframes;
		
	while (wave_length - offset < frames_left) {
		memcpy (buffer + (nframes - frames_left), wave.ptr + offset, sample_t.sizeof * (wave_length - offset));
		frames_left -= wave_length - offset;
		offset = 0;
	}
	if (frames_left > 0) {
		memcpy (buffer + (nframes - frames_left), wave.ptr + offset, sample_t.sizeof * frames_left);
		offset += frames_left;
	}
}

extern (C)
int
process (jack_nframes_t nframes, void *arg)
{
	if (transport_aware) {
		jack_position_t pos;

		if (jack_transport_query (client, &pos)
		    != JackTransportRolling) {

			process_silence (nframes);
			return 0;
		}
		offset = pos.frame % wave_length;
	}
	process_audio (nframes);
	return 0;
}

extern (C)
int
sample_rate_change () {
	Trace.formatln("Sample rate has changed! We should exit, but I don't know how.");
	//exit(-1);
	return 1;
}



int main(char[][] args)
{
	Trace.formatln("Hello Jack, D calling.");

	//The C version had a lot of command line options,
	//but as this is not an example of how to use them
	//I just replaced all the options with some predefined
	//values and no options at all.
	//This is just a Jack helloworld, anyway.

	sample_t scale;
	int i, attack_length, decay_length;
	double[] amp;
	double max_amp = 0.9;
	int option_index;
	int opt;
	int got_bpm = 65;
	int attack_percent = 3, decay_percent = 50, dur_arg = 700;
	char[] client_name = "metrod";
	char[] bpm_string = "bpm";
	int verbose = 0;

	//These will be the output ports, that we get from the system,
	//these are just in case the Jack server is already running, so we automatically
	//hook up to it. The C version didn't do this, so it might be a better idea not to,
	//but I don't know. It works ok this way, anyway.
	jack_port_t* playback_port1;
	jack_port_t* playback_port2;

	//All the strings you give to jack, must be stringz.toStringzed.
	//I guess it add a \0 to the end and makes it a char* pointer,
	//but I'm not sure.
	
	//All the C enums are now D enums, meaning they are more strongly
	//typed. This might be a bit of nuisance, as you'll have to find the
	//enum types for all the enums you have in your C examples and tutorials.
	//But atleast some errors might be found more easily, because of stronger
	//typing. If this annoys you, you could always alter the bindings and
	//make the enums anonymous.
	
	//Open the jack client.
	if(( client = jack_client_open(stringz.toStringz(client_name),
										JackOptions.JackNullOption,
										null)) == null)
	{
		Trace.formatln("jack server not running?\n");
		return 1;
	}
	
	//Set the callbacks and register out port for output.
	jack_set_process_callback (client, &process, null);
	output_port = jack_port_register (client, stringz.toStringz("beat"), JACK_DEFAULT_AUDIO_TYPE, JackPortFlags.JackPortIsOutput, 0);

	sr = jack_get_sample_rate (client);

	/* setup wave table parameters */
	wave_length = 60 * sr / bpm;
	tone_length = sr * dur_arg / 1000;
	attack_length = tone_length * attack_percent / 100;
	decay_length = tone_length * decay_percent / 100;
	scale = 2 * PI * freq / sr;

	if (tone_length >= wave_length) {
		Trace.formatln("invalid duration (tone length = {}, wave length = {}", tone_length,
			 wave_length);
		return -1;
	}
	if (attack_length + decay_length > cast(int)tone_length) {
		Trace.formatln("invalid attack/decay");
		return -1;
	}

	/* Build the wave table */
	//wave = cast(sample_t *) malloc (wave_length * sample_t.sizeof);
	//amp = cast(double *) malloc (tone_length * double.sizeof);
	wave.alloc(wave_length);
	amp.alloc(tone_length);
	
	for (i = 0; i < attack_length; i++) {
		amp[i] = max_amp * i / (cast(double) attack_length);
	}
	for (i = attack_length; i < cast(int)tone_length - decay_length; i++) {
		amp[i] = max_amp;
	}
	for (i = cast(int)tone_length - decay_length; i < cast(int)tone_length; i++) {
		amp[i] = - max_amp * (i - cast(double) tone_length) / (cast(double) decay_length);
	}
	for (i = 0; i < cast(int)tone_length; i++) {
		wave[i] = amp[i] * Math.sin (scale * i);
	}
	for (i = tone_length; i < cast(int)wave_length; i++) {
		wave[i] = 0;
	}

	if (jack_activate (client)) {
		Trace.formatln("cannot activate client");
		return 1;
	}
	
	//This wasn't in the C example, so you had to connect it yourself:
	
	//We get the stereo output ports from jack...
	if ((playback_port1 = jack_port_by_name(client, "system:playback_1")) == null) {
		Trace.formatln("ERROR {} not a valid port", "system:playback_1");
		/*return 1;*/
	}
	
	if ((playback_port2 = jack_port_by_name(client, "system:playback_2")) == null) {
		Trace.formatln("ERROR {} not a valid port", "system:playback_2");
		/*return 1;*/
	}
		
	//...and connect our own output_port to them.
	if (jack_connect(client, jack_port_name(output_port), jack_port_name(playback_port1))) {
		Trace.formatln("cannot connect to port system:playback_2");
		return 1;
	}
	
	if (jack_connect(client, jack_port_name(output_port), jack_port_name(playback_port2))) {
		Trace.formatln("cannot connect to port system:playback_1");
		return 1;
	}


	while(1)
	{
		//loop
	}
	
	return 0;
}

