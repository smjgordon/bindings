/*  VideoFileQT.d
 *  
 *  C++ version:
 *  Copyright (C) 2005 Richard Spindler <richard.spindler AT gmail.com>
 *
 *  D version:
 *  Copyright (C) 2008 Jonas Kivi <satelliittipupu AT yahoo.co.uk>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

module VideoFileQT;

import tango.io.Stdout;
import stringz = tango.stdc.stringz;

import lqt.lqt;
import lqt.colormodels;
//import lqt.version;

public import globals;
import IVideoFile;
import frame_struct;
import aspecthelper;

class VideoFileQT : public IVideoFile
{
public:
	this( char[] filename )
	{
		m_ok = false;
		m_qt = null;
		//m_frame = null;
		//m_rows = null;
		
		char* lqt_filename = stringz.toStringz(filename);
		
		if ( !quicktime_check_sig( lqt_filename ) )
		{
			Stdout( "This is not a Quicktime video file\n" );
			return;
		}
		m_qt = quicktime_open( lqt_filename, true, false );
		if ( m_qt is null )
		{
			Stdout( "Could not open Quicktime file\n" );
			return;
		}
		if ( quicktime_video_tracks( m_qt ) == 0 )
		{
			Stdout( "This Quicktime file does not have a video track\n" );
			return;
		}
		if ( !quicktime_supported_video( m_qt, 0 ) )
		{
			Stdout( "This Video Codec is not supported\n" );
			return;
		}
		// check frame rate
		int64_t frame_duration = lqt_frame_duration( m_qt, 0, null );
		int64_t time_scale = lqt_video_time_scale( m_qt, 0 );
		m_ticksPerFrame = ( frame_duration * NLE_TIME_BASE ) / time_scale;
		
		lqt_set_cmodel( m_qt, 0, BC_RGB888);
		m_width = quicktime_video_width( m_qt, 0 );
		m_height = quicktime_video_height( m_qt, 0 );
		m_frame = new ubyte[m_width * m_height * 3];
		m_rows = new ubyte*[m_height];
		for (int i = 0; i < m_height; i++)
		{
			m_rows[i] = m_frame.ptr + m_width * 3 * i;
		}
		m_framestruct.x = 0;
		m_framestruct.y = 0;
		m_framestruct.w = m_width;
		m_framestruct.h = m_height;
		m_framestruct.RGB = m_frame.ptr;
		m_framestruct.YUV = null;
		m_framestruct.rows = m_rows;
		m_framestruct.alpha = 1.0;
		m_framestruct.has_alpha_channel = false;
		m_framestruct.cacheable = false;
		m_framestruct.interlace_mode = InterlaceType.PROGRESSIVE;
		m_framestruct.first_field = true;
		m_framestruct.scale_x = 0;
		m_framestruct.scale_y = 0;
		m_framestruct.crop_left = 0;
		m_framestruct.crop_right = 0;
		m_framestruct.crop_top = 0;
		m_framestruct.crop_bottom = 0;
		m_framestruct.tilt_x = 0;
		m_framestruct.tilt_y = 0;
		//m_framestruct.interlace_mode = InterlaceType.PROGRESSIVE; //removed duplicate...
	
			switch ( lqt_get_interlace_mode( m_qt, 0 ) )
			{
				case LQT_INTERLACE_NONE:
					m_framestruct.interlace_mode = InterlaceType.PROGRESSIVE;
				break;
				case LQT_INTERLACE_TOP_FIRST:
					m_framestruct.interlace_mode = InterlaceType.TOP_FIELD_FIRST;
				break;
				case LQT_INTERLACE_BOTTOM_FIRST:
					m_framestruct.interlace_mode = InterlaceType.BOTTOM_FIELD_FIRST;
					/*for (int i = 0; i < m_height/2; i++) {
						m_rows[i*2 + 1] = m_frame + m_width * 3 * i;
						m_rows[i*2] = m_frame + m_width * 3 * i + m_width * 3 * m_height / 2;
					}
					m_framestruct.interlace_mode = INTERLACE_DEVIDED_FIELDS; */
				break;
			}
		
		m_interlace_mode = m_framestruct.interlace_mode;
	
		guess_aspect( m_framestruct.w, m_framestruct.h, &m_framestruct );
	
		m_filename = filename;
		m_ok = true;
	}
	
	~this()
	{
		if ( m_frame !is null )
			delete m_frame;
		if ( m_rows !is null )
			delete m_rows;
		if ( m_qt !is null )
			quicktime_close( m_qt );
	}
	
	int64_t length()
	{
		return quicktime_video_length( m_qt, 0 ) * m_ticksPerFrame;
	}
	
	/*
	//Why isn't this enabled?
	double fps()
	{
		return quicktime_frame_rate( m_qt, 0 ); 
	}
	*/
	
	frame_struct** getFrameStack( int64_t whatsthis )
	{
		return null;
	}
	
	frame_struct* getFrame( int64_t position )
	{
		if( m_interlace_mode )
		{
			m_first_field = ( position % ticksPerFrame() < ticksPerFrame() / 2 );
		}
		int64_t frameNum = position / ticksPerFrame();
		if ( m_lastFramePosition + 1 == frameNum )
		{
			m_lastFramePosition = frameNum;
			return read();
		}
		else
		{
			m_lastFramePosition = frameNum;
			seekToFrame( frameNum );
			return read();
		}
	}
	
	frame_struct* read()
	{
		quicktime_decode_video( m_qt, m_rows.ptr, 0);
		m_framestruct.alpha = 1.0;
		m_framestruct.first_field = m_first_field;
		return &m_framestruct;
	}
	
	void read( ubyte*[] rows, int w, int h )
	{
		quicktime_decode_scaled( m_qt, 0, 0, m_width, m_height, w, h, BC_RGB888, rows.ptr, 0 );
	}
	
	void seek( int64_t position )
	{
		int64_t p = position / m_ticksPerFrame;
		if ( p >= quicktime_video_length( m_qt, 0 ) )
		{
			p = quicktime_video_length( m_qt, 0 ) - 1;
		}
		quicktime_set_video_position( m_qt, p, 0 );
	}
	
	void seekToFrame( int64_t frame )
	{
		quicktime_set_video_position( m_qt, frame, 0 );
	}
		
//Properties:
protected:
	
	protected char[] m_filename = "";
	public char[] filename() { return m_filename; }
	
	public InterlaceType interlacing() { return m_interlace_mode; }
	protected InterlaceType m_interlace_mode = InterlaceType.PROGRESSIVE;
	
	public int width() { return m_width; }
	protected int m_width;
	public int height() { return m_height; }
	protected int m_height;
	
	int64_t m_lastFramePosition = -1; //TODO: is this ticks or frames? frames is propably more useful
	bool m_first_field = true;
	
	quicktime_t* m_qt = null;
	ubyte[] m_frame;// = null;
	ubyte*[] m_rows;// = null;
	frame_struct m_framestruct;
	public bool ok() { return m_ok; }
	protected bool m_ok = false;
	public int64_t ticksPerFrame() { return m_ticksPerFrame; }
	protected int64_t m_ticksPerFrame;
	
	
}

