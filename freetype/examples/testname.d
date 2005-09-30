module testname;

import freetype.ft;
import std.stdio;
import std.string;

int main(char[][] args)
{
	FT_Library			fontLibrary;
	FT_Face				fontFace;
	FT_Bitmap			bitmap;
	FT_GlyphSlot		curGlyph;
	FT_Glyph_Metrics 	glyphMetrics;
	FT_Error			err;
	FT_Glyph			glyphObject;

	int 		glyphIndex;
	int 		numChars;
	char[256]	charName;

	if (args.length != 2)
	{
		writefln("Not enough arguments on command line!");
		return 1;
	}
	if ( FT_Init_FreeType( &fontLibrary ) )
	{
		writefln("FT_Init_FreeType failed: ", __LINE__);
		return 1;
	}

	writefln("FT_Init_FreeType success!");

	if ( (err = FT_New_Face( fontLibrary, toStringz(args[1]), 0, &fontFace )) != 0 )
	{
		writefln("FT_New_Face failed: ", __LINE__);
		writefln((*fontLibrary).sizeof);
		writefln( err );
		return 1;
	}

	writefln("FT_New_Face success!");

	if ( FT_Set_Char_Size( fontFace, 0, 768, 300, 300 ) )
	{
		writefln("FT_Set_Char_Size failed: ", __LINE__ );
		return 1;
	}

	writefln("FT_Set_Char_Size success!");

	numChars = cast(int)fontFace.num_glyphs;

	FT_Set_Transform( fontFace, null, null );

	writefln("FT_Set_Transform success!");
	writefln();
	
	for ( glyphIndex = 0; glyphIndex < numChars; glyphIndex++ )
	{
		if ( FT_Load_Glyph( fontFace, glyphIndex, FT_LOAD_DEFAULT ) )
		{
			writefln(" FT_Load_Glyph failed:", __LINE__ );
			return 1;
		}

		// writefln( "FT_Load_Glyph success!" );

		curGlyph = fontFace.glyph;

		if ( curGlyph.format != FT_Glyph_Format.FT_GLYPH_FORMAT_BITMAP )
		{
			if ( FT_Render_Glyph( fontFace.glyph, FT_Render_Mode.FT_RENDER_MODE_MONO ) )
			{
				writefln("FT_Render_Glyph failed: ", __LINE__ );
				return 1;
			}
		//	writefln( "FT_Render_Glyph success!" );
		}

		if ( FT_Get_Glyph_Name( fontFace, glyphIndex, charName, 16 ) )
		{
			writefln( "FT_Get_Glyph_Name failed: ", __LINE__ );
			return 1;
		}

		// writefln( "FT_Get_Glyph_Name success!" );

		bitmap = curGlyph.bitmap;
		glyphMetrics = curGlyph.metrics;

		writefln ( "Glyph ", glyphIndex ,
				   "  name ", toString(charName) );
		
		writefln ( glyphMetrics.horiBearingX/64, " ",
				   glyphMetrics.horiBearingY/64, " ",
				   glyphMetrics.horiAdvance/64, " ",
				   bitmap.width, " ", bitmap.rows );
	}
	
	if (FT_Get_Glyph( curGlyph, &glyphObject ) )
	{
		writefln( "FT_Get_Glyph Failed: ", __LINE__ );
		return 1;
	}

	if (glyphObject)
		writefln( "glyphObject is NOT null!" );

	writefln();
	writefln();
	writefln( "FT_Get_Glyph success!" );

	return 0;
}