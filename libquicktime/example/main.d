module main;

private import gtk.VBox;
private import gtkglc.gl;
private import gtkglc.glu;
//private import gl.TrackBall;

//private import gtkc.glibtypes;

import gdkkeysyms;

version (Tango)
{
    private import tango.io.Stdout;
    private import tango.math.Math;
    //private import tango.stdc.math;//std.math;
    //private import tango.stdc.stdio;//std.stdio;
}
else
{
    private import std.c.stdio;
    private import std.math;
}

static void
init_view ()
{
}


import lqt.lqt;
import VideoFileQT;


private import glgdk.GLConfig;
private import glgdk.GLContext;
private import glgdk.GLDraw;
private import glgdk.GLDrawable;
private import gtkglc.glgdktypes;
private import gtkglc.glgtktypes;

private import glgtk.GLCapability;
private import glgtk.GLWidget;

private import gtk.GtkD;

private import gtk.DrawingArea;
private import gtk.Layout;
private import gtk.Menu;
private import gtk.MenuItem;
private import gtk.Widget;
private import gtk.Button;
private import gtk.MainWindow;
private import gdk.Event;
private import gdk.EventStruct;

private import gtk.Idle;
private import gtk.Timeout;



/**
 * A GL toggle button
 */
class VideoViewer : DrawingArea
{

	//My stuff:
	bool play = true;
	void playPause()
	{
		if( play == true ) play = false;
		else play = true;
	}
	
	uint currentVideo = 0;
	int64_t fcursor = 0;
	float x_aspect = 1.78f;
	float y_aspect = 1.0f;

	//To be removed or changed stuff:
	GLfloat xrot = 0.0f;      /* X Rotation */
	GLfloat yrot = 0.0f;      /* Y Rotation */
	GLfloat xspeed = 0.0f;    /* X Rotation Speed */
	GLfloat yspeed = 0.0f;    /* Y Rotation Speed */
	GLfloat z = -5.0f; /* Depth Into The Screen */

	//Lights:
	/* Ambient Light Values ( NEW ) */
	GLfloat LightAmbient[] = [ 0.5f, 0.5f, 0.5f, 1.0f ];
	/* Diffuse Light Values ( NEW ) */
	GLfloat LightDiffuse[] = [ 1.0f, 1.0f, 1.0f, 1.0f ];
	/* Light Position ( NEW ) */
	GLfloat LightPosition[] = [ 0.0f, 0.0f, 2.0f, 1.0f ];

	//TestGL testGL;
	
	bool animate = false;

	//GLfloat angle = 0.0;
	//GLfloat pos_y = 0.0;

	//int idleID;
	
	Idle mainIdle;
	
	//DrawingArea da;
	
	Menu menu;
	
	/** need to include the mixin to add GL capabilities to this widget */
	mixin GLCapability;

	GLfloat width;
	GLfloat height;
	
	this(char[] set_lqt_filename, char[] set_lqt_filename1, char[] set_lqt_filename2 )//TestGL testGL)
	{
		lqt_filename = set_lqt_filename;
		lqt_filename1 = set_lqt_filename1;
		lqt_filename2 = set_lqt_filename2;

		//this.testGL = testGL;
		//super(false,0);
		//super(null, null);
		setGLCapability();	// set the GL capabilities for this widget
	
		setSizeRequest(800,400);		
		addOnRealize(&realizeCallback);						// dispatcher.addRealizeListener(this,da);
		addOnMap(&mapCallback);								// dispatcher.addMapListener(this,da);
		addOnExpose(&exposeCallback);						// dispatcher.addExposeListener(this,da);
		//addOnConfigure(&configureCallback);					// dispatcher.addConfigureListener(this,da);
		addOnVisibilityNotify(&visibilityCallback);			// dispatcher.addVisibilityListener(this,da);
		//dispatcher.addButtonClickedListener(this,da);
		addOnButtonPress(&mouseButtonPressCallback);		// dispatcher.addMouseButtonListener(this,da);
		addOnButtonRelease(&mouseButtonReleaseCallback);	// dispatcher.addMouseMotionListener(this,da);
			
		addOnKeyPress(&onKeyPress);	
			
		//da.addOnVisibilityNotify(&visibilityCallback);
			
		addOnMotionNotify(&motionNotifyCallback);
			
		//menu = createPopupMenu();
		
		initVideo();
	}		

	char[] lqt_filename = "";
	char[] lqt_filename1 = "";
	char[] lqt_filename2 = "";
	//char[] lqt_filename3 = "";
	//char[] lqt_filename4 = "";

	uint nro_videos = 3;
	VideoFileQT[3] qtvideo;
	frame_struct* fs;
	
	static GLuint video_canvas[10];
	const T_W_F = 2048.0;
	const T_H_F = 2048.0;
	const T_W = 2048; //368
	const T_H = 2048; //240
	const TEXTURE_WIDTH = 2048.0;
	const TEXTURE_HEIGHT = 2048.0;

	ubyte[3 * T_W * T_H] p = [ 0 ];

	void initVideo()
	{
		qtvideo[0] = new VideoFileQT( lqt_filename );
		qtvideo[1] = new VideoFileQT( lqt_filename1 );
		qtvideo[2] = new VideoFileQT( lqt_filename2 );
		//qtvideo[3] = new VideoFileQT( lqt_filename3 );
		//qtvideo[4] = new VideoFileQT( lqt_filename4 );
		
		for( uint i = 0; i < qtvideo.length; i++ )
		{
			if( qtvideo[i] is null )
				Stdout("Could not open Quicktime file ")(i)("\n");
		}
		
		Stdout("\nwidth: ")(qtvideo[0].width());
		Stdout("\nheight: ")(qtvideo[0].height());
		
		Stdout("\ntickPerFrame: ")(qtvideo[0].ticksPerFrame());
		Stdout("\nlength0: ")(qtvideo[0].length());
		Stdout("\nlength1: ")(qtvideo[1].length());
		Stdout("\nlength2: ")(qtvideo[2].length()).newline;
		
		fs = qtvideo[currentVideo].getFrame( fcursor );
	}

	void initVideoGL()
	{
		glGenTextures( 10, video_canvas.ptr );
		for ( int i = 0; i < 10; i++ )
		{
			glBindTexture (GL_TEXTURE_2D, video_canvas[i] );
			glPixelStorei (GL_UNPACK_ALIGNMENT, 1);
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
			glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
			glTexImage2D (GL_TEXTURE_2D, 0, GL_RGBA, T_W, T_H, 0, GL_RGB, GL_UNSIGNED_BYTE, p.ptr);
		}
		
		glBindTexture( GL_TEXTURE_2D, video_canvas[0] );
		
		
	}


	int visibilityCallback(GdkEventVisibility* e, Widget widget)
	{
		if (animate)
		{
			if (e.state == VisibilityState.FULLY_OBSCURED)
			{
				removeIdle();
			}
			else
			{
				addIdle();
			}
		}
		
		return true;
	}

	
	bool idleCallback()
	{
		glDrawFrame(this);
		return true;
	}
	
	int exposeCallback(GdkEventExpose* e, Widget widget)
	{
		glDrawFrame(widget);
		return true;
	}
	
	/**
	 * put any gl initializations here
	 * returns true to consume the event
	 */
	bool initGL()
	{
		/* Enable Texture Mapping ( NEW ) */
    glEnable( GL_TEXTURE_2D );

    /* Enable smooth shading */
    glShadeModel( GL_SMOOTH );

    /* Set the background black */
    //glClearColor( 0.0f, 0.0f, 0.0f, 0.0f );
    glClearColor( 0.1f, 0.2f, 0.1f, 1.0f );

    /* Depth buffer setup */
    glClearDepth( 1.0f );

    /* Enables Depth Testing */
    glEnable( GL_DEPTH_TEST );

    /* The Type Of Depth Test To Do */
    glDepthFunc( GL_LEQUAL );

    /* Really Nice Perspective Calculations */
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );

    /* Setup The Ambient Light */
    glLightfv( GL_LIGHT1, GL_AMBIENT, LightAmbient.ptr );

    /* Setup The Diffuse Light */
    glLightfv( GL_LIGHT1, GL_DIFFUSE, LightDiffuse.ptr );

    /* Position The Light */
    glLightfv( GL_LIGHT1, GL_POSITION, LightPosition.ptr );

    /* Enable Light One */
    glEnable( GL_LIGHT1 );

    /* Full Brightness, 50% Alpha ( NEW ) */
    glColor4f( 1.0f, 1.0f, 1.0f, 0.5f);

    /* Blending Function For Translucency Based On Source Alpha Value  */
    //glBlendFunc( GL_SRC_ALPHA, GL_ONE );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
	
		
	/*
		// Change to texture matrix and flip and rotate the texture
		glMatrixMode(GL_TEXTURE);
		glRotatef(180.0f, 0.0f, 0.0f, 1.0f);
		glScalef(-1.0f, 1.0f, 1.0f);
		// Back to normal
		glMatrixMode(GL_MODELVIEW);
	*/
		
		return true;
	}
	

private import gdk.Font;
private import gdk.Drawable;
private import gdk.GC;
	
	bool drawGL(GdkEventExpose* event = null)
	{
		/* These are to calculate our fps */
    //static GLint T0     = 0;
    //static GLint Frames = 0;

    /* Clear The Screen And The Depth Buffer */
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    /* Reset the view */
    glLoadIdentity( );

		glScalef(1.0f, -1.0f, 1.0f);

    /* Translate Into/Out Of The Screen By z */
    glTranslatef( 0.0f, 0.0f, z );

    glRotatef( xrot, 1.0f, 0.0f, 0.0f); /* Rotate On The X Axis By xrot */
    glRotatef( yrot, 0.0f, 1.0f, 0.0f); /* Rotate On The Y Axis By yrot */

		drawVideo();

		//Move these to idle:
		xrot += xspeed; /* Add xspeed To xrot */
    yrot += yspeed; /* Add yspeed To yrot */
		
		if( xspeed > 0.1f )
			xspeed -= 0.1f;
		else if( xspeed < -0.1f )
			xspeed += 0.1f;
		else xspeed = 0.0f;
		if( yspeed > 0.1f )
			yspeed -= 0.1f;
		else if( yspeed < -0.1f )
			yspeed += 0.1f;
		else yspeed = 0.0f;
		
		
		return true;
	}
	
	void drawVideo()
	{
			if( currentVideo >= nro_videos )//Start from the start again.
					currentVideo = 0;
				
				if( play == true )
				{
					fcursor += qtvideo[currentVideo].ticksPerFrame();//400000l;//frame_duration;
					fs = qtvideo[currentVideo].getFrame( fcursor );
				}
				
				if( fcursor >= qtvideo[currentVideo].length() )
				{
					currentVideo++;
					fcursor = 0;
				}
					
				if( currentVideo >= nro_videos )//Start from the start again.
					currentVideo = 0;
				
				//cout<<"fcursor: "<<fcursor;
				
				glBindTexture( GL_TEXTURE_2D, video_canvas[0] );

				ubyte* framebuffer;
				framebuffer = fs.RGB;

				//glTexSubImage2D( GL_TEXTURE_2D, 0, 0, 0, fs.w, fs.h/2, GL_RGB, GL_UNSIGNED_BYTE, framebuffer );
				glTexSubImage2D( GL_TEXTURE_2D, 0, 0, 0, fs.w, fs.h, GL_RGB, GL_UNSIGNED_BYTE, framebuffer );
				
				glBindTexture( GL_TEXTURE_2D, video_canvas[0] );
				
				float gl_x, gl_y, gl_w, gl_h;
				
				/*
				gl_x = -2.5f;
				gl_y = -2.0f;
				gl_w = 5.0f;
				gl_h = 6.0f;
				*/
				
				gl_w = x_aspect * 3.0f;//4.0f;
				gl_h = y_aspect * 3.0f;//3.0f;
				gl_x = -gl_w * 0.5f;//-2.0f;
				gl_y = -gl_h * 0.5f;//-1.5f;
				
				
				float ww = ( fs.w ) / TEXTURE_WIDTH;
				float xx = 0.0f;
				float hh = fs.h / TEXTURE_HEIGHT;
				
				glColor4f( 1.0f, 1.0f, 1.0f, fs.alpha ); //Control Transparency
				glBegin (GL_QUADS);
					glTexCoord2f	(	xx,						0.0 );
					glVertex3f		(	gl_x,					gl_y,					0.0 );
					glTexCoord2f	(	xx + ww,			0.0 );  			// (fs.w / 512.0)
					glVertex3f		(	gl_x + gl_w,	gl_y,					0.0 );
					glTexCoord2f	(	xx + ww,			hh );					// (368.0 / 512.0) (240.0 / 512.0)
					glVertex3f		(	gl_x + gl_w,	gl_y + gl_h,	0.0 );
					glTexCoord2f	(	xx,						hh );					// (fs.h / 512.0)
					glVertex3f		(	gl_x,					gl_y + gl_h,	0.0 );
				glEnd ();
	
	}
	

	bool noExposeCallback(Widget widget){return false;}

	int resizeGL(GdkEventConfigure* e)
	{
		GLfloat w = 0.0f;
		GLfloat h = 0.0f;
		
		if ( e == null )
		{
			w = getWidth();
			h = getHeight();
		}
		else
		{
			w = e.width;
			h = e.height;
		}
		
		width = w;
		height = h;
	
		/* Height / width ration */
    GLfloat ratio;
 
    /* Protect against a divide by zero */
    if ( height == 0.0f )
			height = 1.0f;

    ratio = width / height;

    /* Setup our viewport. */
    glViewport( 0, 0, cast(GLint)width, cast(GLint)height );

    /* change to the projection matrix and set our viewing volume. */
    glMatrixMode( GL_PROJECTION );
    glLoadIdentity( );

    /* Set our perspective */
    gluPerspective( 45.0f, ratio, 0.1f, 100.0f );

    /* Make sure we're chaning the model view and not the projection */
    glMatrixMode( GL_MODELVIEW );

    /* Reset The View */
    glLoadIdentity( );
	
		/*GLfloat w;
		GLfloat h;
		
		if ( e == null )
		{
			w = getWidth();
			h = getHeight();
		}
		else
		{
			w = e.width;
			h = e.height;
		}
		
		width = w;
		height = h;
		
		GLfloat aspect;

		glViewport(0, 0, cast(int)w, cast(int)h);
		
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();

		double x = w/h;
		double y = 1.0;
		if ( x > 1.0 )
		{
			y = h/w;
			x = 1.0;
		}
		glFrustum (-x, x, -y, y, 5.0, 60.0);

		//if (w > h)
		//{
		//	aspect = w / h;
		//	glFrustum(-aspect, aspect, -1.0, 1.0, 5.0, 60.0);
		//}
		//else
		//{
		//	aspect = h / w;
		//	glFrustum(-1.0, 1.0, -aspect, aspect, 5.0, 60.0);
		//}
		
		glMatrixMode(GL_MODELVIEW);
		*/
		return true;
	}

	void addIdle()
	{
		if ( mainIdle is null )
		{
			mainIdle = new Idle(&idleCallback);
		}
	}
	
	void removeIdle()
	{
		if ( mainIdle !is null )
		{
			mainIdle.stop();
			mainIdle = null;
		}
	}

	void mapCallback(Widget drawable)
	{
		if (animate)
		{
			addIdle();
		}
	}

	void unmapCallback(Widget drawable)
	{
		removeIdle();
	}

//	void buttonClickedCallback(Button button, String action)
//	{
//	}

	void realizeCallback(Widget widget)
	{
		GLContext context = GLWidget.getGLContext(widget);
		GLDrawable drawable = GLWidget.getGLDrawable(widget);
		
		/*** OpenGL BEGIN ***/
		if (!drawable.glBegin(context) )
		{
			return ;
		}
		
		glClearColor(0.5, 0.5, 0.8, 1.0);
		glClearDepth(1.0);
			
		initGL();
		resizeGL(null);
		
		initVideoGL();
		
		toggleAnimation();
		
		drawable.glEnd();
		/*** OpenGL END ***/
		
		return;
	}

	bool unrealizeCallback(Widget widget){return false;}


static float begin_x = 0.0;
static float begin_y = 0.0;

static float dx = 0.0;
static float dy = 0.0;


	int mouseButtonPressCallback(GdkEventButton*event, Widget widget)
	{
		if (event.button == 1)
		{
			if (animate)
			{
				toggleAnimation();
			}
		}
		
		begin_x = event.x;
		begin_y = event.y;
		
		return false;
	}
	
	int mouseButtonReleaseCallback(GdkEventButton*event, Widget widget)
	{
		if (event.button == 1)
		{
			/*if (!animate && ((dx*dx + dy*dy) > ANIMATE_THRESHOLD))
			{
				toggleAnimation();
			}*/
		}
		else if (event.button == 3)
		{
			/* Popup menu. */
			//menu.popup(null,null,null,null,event.button, event.time);
			return true;
		}
		
		dx = 0.0;
		dy = 0.0;
		
		return false;
	}

	int motionNotifyCallback(GdkEventMotion* event, Widget widget)
	{
		float w = width;
		float h = height;
		float x = event.x;
		float y = event.y;
		gboolean redraw = false;
		
		/* Rotation. */
		if (event.state == ModifierType.BUTTON1_MASK )
		{
				dx = x - begin_x;
				dy = y - begin_y;
			
			redraw = true;
		}
		
		/* Scaling. */
		if (event.state == ModifierType.BUTTON2_MASK )
		{
			redraw = true;
		}
		
		begin_x = x;
		begin_y = y;
		
		if (redraw && !animate)
		{
			queueDraw();
		}
		
		return true;
	}

//static gboolean
//key_press_event (GtkWidget   *widget,
//		 GdkEventKey *event,
//		 gpointer     data)
//{
//  switch (event.keyval)
//    {
//    case GDK_Escape:
//      gtk_main_quit ();
//      break;
//
//    default:
//      return false;
//    }
//
//  return true;
//}


	int onKeyPress( GdkEventKey* event, Widget widget)
	{
		//debug(Movie) Stdout("Movie.onKeyPress() START and END.").newline;
		
		/*enum
		{
			GDK_0 = 0x030,
			GDK_1 = 0x031,
			GDK_2 = 0x032,
			GDK_3 = 0x033,
			GDK_4 = 0x034,
			GDK_5 = 0x035,
			GDK_6 = 0x036,
			GDK_7 = 0x037,
			GDK_8 = 0x038,
			GDK_9 = 0x039,
			GDK_a = 0x061,

			GDK_BackSpace = 0xFF08,

			GDK_Home = 0xFF50,
			
			GDK_Left = 0xFF51,
			GDK_Up = 0xFF52,
			GDK_Right = 0xFF53,
			GDK_Down = 0xFF54,

			GDK_Prior = 0xFF55,
			GDK_Page_Up = 0xFF55,
			GDK_Next  = 0xFF56,
			GDK_Page_Down = 0xFF56,
			GDK_End = 0xFF57,

			GDK_space = 0x020

		}
		*/
		
		if(event !is null)
		{
			//Stdout("KeyDown.");
			switch( event.keyval )
			{
				default:
				break;
				case GDK_Escape:
					
					GtkD.mainQuit();
				break;
				
				case GDK_space:
					//toggleAnimation();//no.
					playPause();
				break;
				
				case GDK_Down:
				case GDK_Up:
				//case GDK_r:
					fcursor = 0;
				break;
				case GDK_Left:
					fcursor = 0;
					currentVideo--;
				break;
				case GDK_Right:
					fcursor = 0;
					currentVideo++;
				break;
				case GDK_1:
					Stdout("aspect ratio: 16:9 (1:1.78)").newline;
					x_aspect = 1.78f;
					y_aspect = 1.0f;
				break;
				case GDK_2:
					Stdout("aspect ratio: 4:3 (1:1.333)").newline;
					x_aspect = 1.333f;
					y_aspect = 1.0f;
				break;
				case GDK_3:
					Stdout("aspect ratio: 1:2").newline;
					x_aspect = 2.0f;
					y_aspect = 1.0f;
				break;
				case GDK_z:
					xrot = 0.0f;
					yrot = 0.0f;
					xspeed = 0.0f;
					yspeed = 0.0f;
				break;
				case GDK_u:
					z -= 0.5f;
				break;
				case GDK_o:
					z += 0.5f;
				break;
				case GDK_i:
					xspeed += 0.5f;
					//Stdout("i pressed.")("xspeed: ")(xspeed).newline;
				break;
				case GDK_k:
					xspeed -= 0.5f;
					//Stdout("k pressed.")("xspeed: ")(xspeed).newline;
				break;
				case GDK_l:
					yspeed += 0.5f;
					//Stdout("l pressed.")("yspeed: ")(yspeed).newline;
				break;
				case GDK_j:
					yspeed -= 0.5f;
					//Stdout("j pressed.")("yspeed: ")(yspeed).newline;
				break;
			}
		}
		return true;
	}

	/* Toggle animation.*/
	void toggleAnimation()
	{
		animate = !animate;

		if (animate)
		{
			addIdle();
		}
		else
		{
			removeIdle();
			queueDraw();
		}

	}

//	static void
//	change_shape (GtkMenuItem  *menuitem, GLuint *shape)
//	{
//	  shape_current = *shape;
//	  init_view();
//	}
//
//	static void
//	change_material (GtkMenuItem  *menuitem,
//					 MaterialProp *mat)
//	{
//	  mat_current = mat;
//	}

//	/* For popup menu. */
//	static gboolean
//	button_press_event_popup_menu (GtkWidget      *widget,
//					   GdkEventButton *event,
//					   gpointer        data)
//	{
//	  if (event.button == 3)
//		{
//		  /* Popup menu. */
//		  gtk_menu_popup (GTK_MENU (widget), NULL, NULL, NULL, NULL,
//				  event.button, event.time);
//		  return true;
//		}
//	
//	  return false;
//	}
//

//	void activateCallback(MenuItem menuItem, char[] action)
//	{
//	}
	void activateItemCallback(MenuItem menuItem)
	{
		char[] action = menuItem.getActionName();
		version(Tango)
		{
			Stdout("activateItemCallback action = %s ")( action).newline;
		}
		else //version(Phobos)
		{
    	printf("activateItemCallback action = %.*s \n", action);
    }
		
	/*
		switch(action)
		{
			default: break;
		}
	*/
    	//init_view();
	}
}



public:
class GLVideoPlayerMainWindow : MainWindow
{
	VideoViewer videoViewer;

	this(char[] lqt_filename, char[] lqt_filename1, char[] lqt_filename2 )
	{
		super("GLVideoPlayer 0.0.1 (licence: GPL)");
		setReallocateRedraws(true);
		//setBorderWidth(10);
		
		videoViewer = new VideoViewer(lqt_filename, lqt_filename1, lqt_filename2);
		
		add( videoViewer );
		
		addOnKeyPress(&onKeyPress);
		
		show();
	}
	
	int onKeyPress( GdkEventKey* event, Widget widget)
	{
		/*enum
		{
			GDK_0 = 0x030,
			GDK_1 = 0x031,
			GDK_a = 0x061
		}*/

		if(event !is null)
		{
			videoViewer.onKeyPress( event, widget );
		}
		return true;
	}
	
}
 
 
private import glgdk.GLdInit;

void main(char [][]args)
{
	Stdout("GLVideoPlayer 0.0.1 (licence: GPL)\nGive 3 video (.mov) files as arguments and this program will try to play them with OpenGL (without sound or any kind of sync and no deinterlacing). Keys: ARROWS, rotate:I,J,K,L, reset:Z, zoom:U,O, aspect ratio:1,2,3.").newline;

	GtkD.init(args);

	GLdInit.init(null, null);

	Stdout("The files are: ").newline;
	Stdout("1: ")(args[1]).newline;
	Stdout("2: ")(args[2]).newline;
	Stdout("3: ")(args[3]).newline;

	GLVideoPlayerMainWindow glVideoPlayerMainWindow = new GLVideoPlayerMainWindow(args[1], args[2], args[3]);
	glVideoPlayerMainWindow.showAll();
	
	GtkD.main();	
} 
