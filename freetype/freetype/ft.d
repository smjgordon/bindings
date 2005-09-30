/*
 * File:	freetype/ft.d
 * Author:	John Reimer 
 * Date:    2005-09-18  Initial release
 *
 * Updated: 2005-09-25  Minor changes - JJR @ dsource.org
 */

module freetype.ft;

public import freetype.def;

private 
{
	import freetype.loader;
	debug import std.stdio;
}

private Linker freetype_Linker;

void onLoadFailure( char[] symName )
{
	static int count = 0;
	
	// Count the symbols that failed to load.
	count +=1;
	// And output the name of the failed symbol.
	// Update this for proper error handling in future.
	// Useful for debugging for now.
	writefln( count, "Warning! Failed to load: ", symName );
}
	

static this()
{
	version(Windows) freetype_Linker = new Linker("freetype.dll", &onLoadFailure);
	version(linux)	 freetype_Linker = new Linker("libfreetype.so", &onLoadFailure );

	freetype_Linker.link(freetypeLinks);
	
	debug writefln("* Finished static this(): freetype");
}

static ~this()
{
	delete freetype_Linker;
	debug writefln("* Finished static this(): freetype");
}

// The following was mostly auto-generated from the C Freetype source using a python script

extern(C)
{
	FT_Error		function( FT_Library *alibrary )
			FT_Init_FreeType;
	void		function( FT_Library library, FT_Int *amajor, FT_Int *aminor, FT_Int *apatch )
			FT_Library_Version;
	FT_Error		function( FT_Library library )
			FT_Done_FreeType;
	FT_Error		function( FT_Library library, char* filepathname, FT_Long face_index, FT_Face *aface )
			FT_New_Face;
	FT_Error		function( FT_Library library, FT_Byte* file_base, FT_Long file_size, FT_Long face_index, FT_Face *aface )
			FT_New_Memory_Face;
	FT_Error		function( FT_Library library, FT_Open_Args* args, FT_Long face_index, FT_Face *aface )
			FT_Open_Face;
	FT_Error		function( FT_Face face, char* filepathname )
			FT_Attach_File;
	FT_Error		function( FT_Face face, FT_Open_Args* parameters )
			FT_Attach_Stream;
	FT_Error		function( FT_Face face )
			FT_Done_Face;
	FT_Error		function( FT_Face face, FT_F26Dot6 char_width, FT_F26Dot6 char_height, FT_UInt horz_resolution, FT_UInt vert_resolution )
			FT_Set_Char_Size;
	FT_Error		function( FT_Face face, FT_UInt pixel_width, FT_UInt pixel_height )
			FT_Set_Pixel_Sizes;
	FT_Error		function( FT_Face face, FT_UInt glyph_index, FT_Int32 load_flags )
			FT_Load_Glyph;
	FT_Error		function( FT_Face face, FT_ULong char_code, FT_Int32 load_flags )
			FT_Load_Char;
	void		function( FT_Face face, FT_Matrix* matrix, FT_Vector* delta )
			FT_Set_Transform;
	FT_Error		function( FT_GlyphSlot slot, FT_Render_Mode render_mode )
			FT_Render_Glyph;
	FT_Error		function( FT_Face face, FT_UInt left_glyph, FT_UInt right_glyph, FT_UInt kern_mode, FT_Vector *akerning )
			FT_Get_Kerning;
	FT_Error		function( FT_Face face, FT_UInt glyph_index, FT_Pointer buffer, FT_UInt buffer_max )
			FT_Get_Glyph_Name;
	char*		function( FT_Face face )
			FT_Get_Postscript_Name;
	FT_Error		function( FT_Face face, FT_Encoding encoding )
			FT_Select_Charmap;
	FT_Error		function( FT_Face face, FT_CharMap charmap )
			FT_Set_Charmap;
	FT_Int		function( FT_CharMap charmap )
			FT_Get_Charmap_Index;
	FT_UInt		function( FT_Face face, FT_ULong charcode )
			FT_Get_Char_Index;
	FT_ULong		function( FT_Face face, FT_UInt *agindex )
			FT_Get_First_Char;
	FT_ULong		function( FT_Face face, FT_ULong char_code, FT_UInt *agindex )
			FT_Get_Next_Char;
	FT_UInt		function( FT_Face face, FT_String* glyph_name )
			FT_Get_Name_Index;
	FT_Long		function( FT_Long a, FT_Long b, FT_Long c )
			FT_MulDiv;
	FT_Long		function( FT_Long a, FT_Long b )
			FT_MulFix;
	FT_Long		function( FT_Long a, FT_Long b )
			FT_DivFix;
	FT_Fixed		function( FT_Fixed a )
			FT_RoundFix;
	FT_Fixed		function( FT_Fixed a )
			FT_CeilFix;
	FT_Fixed		function( FT_Fixed a )
			FT_FloorFix;
	void		function( FT_Vector* vec, FT_Matrix* matrix )
			FT_Vector_Transform;
		FT_ListNode		function( FT_List list, void* data )
			FT_List_Find;
	void		function( FT_List list, FT_ListNode node )
			FT_List_Add;
	void		function( FT_List list, FT_ListNode node )
			FT_List_Insert;
	void		function( FT_List list, FT_ListNode node )
			FT_List_Remove;
	void		function( FT_List list, FT_ListNode node )
			FT_List_Up;
	FT_Error		function( FT_List list, FT_List_Iterator iterator, void* user )
			FT_List_Iterate;
	void		function( FT_List list, FT_List_Destructor destroy, FT_Memory memory, void* user )
			FT_List_Finalize;
	FT_Error		function( FT_Outline* outline, FT_Outline_Funcs* func_interface, void* user )
			FT_Outline_Decompose;
	FT_Error		function( FT_Library library, FT_UInt numPoints, FT_Int numContours, FT_Outline *anoutline )
			FT_Outline_New;
	FT_Error		function( FT_Memory memory, FT_UInt numPoints, FT_Int numContours, FT_Outline *anoutline )
			FT_Outline_New_Internal;
	FT_Error		function( FT_Library library, FT_Outline* outline )
			FT_Outline_Done;
	FT_Error		function( FT_Memory memory, FT_Outline* outline )
			FT_Outline_Done_Internal;
	FT_Error		function( FT_Outline* outline )
			FT_Outline_Check;
	void		function( FT_Outline* outline, FT_BBox *acbox )
			FT_Outline_Get_CBox;
	void		function( FT_Outline* outline, FT_Pos xOffset, FT_Pos yOffset )
			FT_Outline_Translate;
	FT_Error		function( FT_Outline* source, FT_Outline *target )
			FT_Outline_Copy;
	void		function( FT_Outline* outline, FT_Matrix* matrix )
			FT_Outline_Transform;
	FT_Error		function( FT_Outline* outline, FT_Pos strength )
			FT_Outline_Embolden;
	void		function( FT_Outline* outline )
			FT_Outline_Reverse;
	FT_Error		function( FT_Library library, FT_Outline* outline, FT_Bitmap *abitmap )
			FT_Outline_Get_Bitmap;
	FT_Error		function( FT_Library library, FT_Outline* outline, FT_Raster_Params* params )
			FT_Outline_Render;
	FT_Orientation		function( FT_Outline* outline )
			FT_Outline_Get_Orientation;
	FT_Error		function( FT_Face face, FT_Size* size )
			FT_New_Size;
	FT_Error		function( FT_Size size )
			FT_Done_Size;
	FT_Error		function( FT_Size size )
			FT_Activate_Size;
	FT_Error		function( FT_Library library, FT_Module_Class* clazz )
			FT_Add_Module;
	FT_Module		function( FT_Library library, char* module_name )
			FT_Get_Module;
	FT_Error		function( FT_Library library, FT_Module mod )
			FT_Remove_Module;
	FT_Error		function( FT_Memory memory, FT_Library *alibrary )
			FT_New_Library;
	FT_Error		function( FT_Library library )
			FT_Done_Library;
	void		function( FT_Library library, FT_UInt hook_index, FT_DebugHook_Func debug_hook )
			FT_Set_Debug_Hook;
	void		function( FT_Library library )
			FT_Add_Default_Modules;
	FT_Error		function( FT_GlyphSlot slot, FT_Glyph *aglyph )
			FT_Get_Glyph;
	FT_Error		function( FT_Glyph source, FT_Glyph *target )
			FT_Glyph_Copy;
	FT_Error		function( FT_Glyph glyph, FT_Matrix* matrix, FT_Vector* delta )
			FT_Glyph_Transform;
	void		function( FT_Glyph glyph, FT_UInt bbox_mode, FT_BBox *acbox )
			FT_Glyph_Get_CBox;
	FT_Error		function( FT_Glyph* the_glyph, FT_Render_Mode render_mode, FT_Vector* origin, FT_Bool destroy )
			FT_Glyph_To_Bitmap;
	void		function( FT_Glyph glyph )
			FT_Done_Glyph;
	void		function( FT_Matrix* a, FT_Matrix* b )
			FT_Matrix_Multiply;
	FT_Error		function( FT_Matrix* matrix )
			FT_Matrix_Invert;
	FT_Renderer		function( FT_Library library, FT_Glyph_Format format )
			FT_Get_Renderer;
	FT_Error		function( FT_Library library, FT_Renderer renderer, FT_UInt num_params, FT_Parameter* parameters )
			FT_Set_Renderer;
	FT_Int		function( FT_Face face )
			FT_Has_PS_Glyph_Names;
	FT_Error		function( FT_Face face, PS_FontInfoRec *afont_info )
			FT_Get_PS_Font_Info;
	FT_Error		function( FT_Face face, PS_PrivateRec *afont_private )
			FT_Get_PS_Font_Private;
	void*		function( FT_Face face, FT_Sfnt_Tag tag )
			FT_Get_Sfnt_Table;
	FT_Error		function( FT_Face face, FT_ULong tag, FT_Long offset, FT_Byte* buffer, FT_ULong* length )
			FT_Load_Sfnt_Table;
	FT_Error		function( FT_Face face, FT_UInt table_index, FT_ULong *tag, FT_ULong *length )
			FT_Sfnt_Table_Info;
	FT_ULong		function( FT_CharMap charmap )
			FT_Get_CMap_Language_ID;
	FT_Error		function( FT_Face face, char* *acharset_encoding, char* *acharset_registry )
			FT_Get_BDF_Charset_ID;
	FT_Error		function( FT_Face face, char* prop_name, BDF_PropertyRec *aproperty )
			FT_Get_BDF_Property;
	FT_Error		function( FT_Stream stream, FT_Stream source )
			FT_Stream_OpenGzip;
	FT_Error		function( FT_Stream stream, FT_Stream source )
			FT_Stream_OpenLZW;
	FT_Error		function( FT_Face face, FT_WinFNT_HeaderRec *aheader )
			FT_Get_WinFNT_Header;
	void		function( FT_Bitmap *abitmap )
			FT_Bitmap_New;
	FT_Error		function( FT_Library library, FT_Bitmap *source, FT_Bitmap *target)
			FT_Bitmap_Copy;
	FT_Error		function( FT_Library library, FT_Bitmap* bitmap, FT_Pos xStrength, FT_Pos yStrength )
			FT_Bitmap_Embolden;
	FT_Error		function( FT_Library library, FT_Bitmap *source, FT_Bitmap *target, FT_Int alignment )
			FT_Bitmap_Convert;
	FT_Error		function( FT_Library library, FT_Bitmap *bitmap )
			FT_Bitmap_Done;
	FT_Error		function( FT_Outline* outline, FT_BBox *abbox )
			FT_Outline_Get_BBox;
	FT_Error		function( FT_Library library, FT_UInt max_faces, FT_UInt max_sizes, FT_ULong max_bytes, FTC_Face_Requester requester, FT_Pointer req_data, FTC_Manager *amanager )
			FTC_Manager_New;
	void		function( FTC_Manager manager )
			FTC_Manager_Reset;
	void		function( FTC_Manager manager )
			FTC_Manager_Done;
	FT_Error		function( FTC_Manager manager, FTC_FaceID face_id, FT_Face *aface )
			FTC_Manager_LookupFace;
	FT_Error		function( FTC_Manager manager, FTC_Scaler scaler, FT_Size *asize )
			FTC_Manager_LookupSize;
	void		function( FTC_Node node, FTC_Manager manager )
			FTC_Node_Unref;
	void		function( FTC_Manager manager, FTC_FaceID face_id )
			FTC_Manager_RemoveFaceID;
	FT_Error		function( FTC_Manager manager, FTC_CMapCache *acache )
			FTC_CMapCache_New;
	FT_UInt		function( FTC_CMapCache cache, FTC_FaceID face_id, FT_Int cmap_index, FT_UInt32 char_code )
			FTC_CMapCache_Lookup;
	FT_Error		function( FTC_Manager manager, FTC_ImageCache *acache )
			FTC_ImageCache_New;
	FT_Error		function( FTC_ImageCache cache, FTC_ImageType type, FT_UInt gindex, FT_Glyph *aglyph, FTC_Node *anode )
			FTC_ImageCache_Lookup;
	FT_Error		function( FTC_Manager manager, FTC_SBitCache *acache )
			FTC_SBitCache_New;
	FT_Error		function( FTC_SBitCache cache, FTC_ImageType type, FT_UInt gindex, FTC_SBit *sbit, FTC_Node *anode )
			FTC_SBitCache_Lookup;
	FT_Error		function( FT_Face face, FT_Multi_Master *amaster )
			FT_Get_Multi_Master;
	FT_Error		function( FT_Face face, FT_MM_Var* *amaster )
			FT_Get_MM_Var;
	FT_Error		function( FT_Face face, FT_UInt num_coords, FT_Long* coords )
			FT_Set_MM_Design_Coordinates;
	FT_Error		function( FT_Face face, FT_UInt num_coords, FT_Fixed* coords )
			FT_Set_Var_Design_Coordinates;
	FT_Error		function( FT_Face face, FT_UInt num_coords, FT_Fixed* coords )
			FT_Set_MM_Blend_Coordinates;
	FT_Error		function( FT_Face face, FT_UInt num_coords, FT_Fixed* coords )
			FT_Set_Var_Blend_Coordinates;
	FT_UInt		function( FT_Face face )
			FT_Get_Sfnt_Name_Count;
	FT_Error		function( FT_Face face, FT_UInt idx, FT_SfntName *aname )
			FT_Get_Sfnt_Name;
	FT_Error		function( FT_Face face, FT_UInt validation_flags, FT_Bytes *BASE_table, FT_Bytes *GDEF_table, FT_Bytes *GPOS_table, FT_Bytes *GSUB_table, FT_Bytes *JSTF_table )
			FT_OpenType_Validate;
	FT_Fixed		function( FT_Angle angle )
			FT_Sin;
	FT_Fixed		function( FT_Angle angle )
			FT_Cos;
	FT_Fixed		function( FT_Angle angle )
			FT_Tan;
	FT_Angle		function( FT_Fixed x, FT_Fixed y )
			FT_Atan2;
	FT_Angle		function( FT_Angle angle1, FT_Angle angle2 )
			FT_Angle_Diff;
	void		function( FT_Vector* vec, FT_Angle angle )
			FT_Vector_Unit;
	void		function( FT_Vector* vec, FT_Angle angle )
			FT_Vector_Rotate;
	FT_Fixed		function( FT_Vector* vec )
			FT_Vector_Length;
	void		function( FT_Vector* vec, FT_Fixed *length, FT_Angle *angle )
			FT_Vector_Polarize;
	void		function( FT_Vector* vec, FT_Fixed length, FT_Angle angle )
			FT_Vector_From_Polar;
	FT_StrokerBorder		function( FT_Outline* outline )
			FT_Outline_GetInsideBorder;
	FT_StrokerBorder		function( FT_Outline* outline )
			FT_Outline_GetOutsideBorder;
	FT_Error		function( FT_Memory memory, FT_Stroker *astroker )
			FT_Stroker_New;
	void		function( FT_Stroker stroker, FT_Fixed radius, FT_Stroker_LineCap line_cap, FT_Stroker_LineJoin line_join, FT_Fixed miter_limit )
			FT_Stroker_Set;
	void		function( FT_Stroker stroker )
			FT_Stroker_Rewind;
	FT_Error		function( FT_Stroker stroker, FT_Outline* outline, FT_Bool opened )
			FT_Stroker_ParseOutline;
	FT_Error		function( FT_Stroker stroker, FT_Vector* to, FT_Bool open )
			FT_Stroker_BeginSubPath;
	FT_Error		function( FT_Stroker stroker )
			FT_Stroker_EndSubPath;
	FT_Error		function( FT_Stroker stroker, FT_Vector* to )
			FT_Stroker_LineTo;
	FT_Error		function( FT_Stroker stroker, FT_Vector* control, FT_Vector* to )
			FT_Stroker_ConicTo;
	FT_Error		function( FT_Stroker stroker, FT_Vector* control1, FT_Vector* control2, FT_Vector* to )
			FT_Stroker_CubicTo;
	FT_Error		function( FT_Stroker stroker, FT_StrokerBorder border, FT_UInt *anum_points, FT_UInt *anum_contours )
			FT_Stroker_GetBorderCounts;
	void		function( FT_Stroker stroker, FT_StrokerBorder border, FT_Outline* outline )
			FT_Stroker_ExportBorder;
	FT_Error		function( FT_Stroker stroker, FT_UInt *anum_points, FT_UInt *anum_contours )
			FT_Stroker_GetCounts;
	void		function( FT_Stroker stroker, FT_Outline* outline )
			FT_Stroker_Export;
	void		function( FT_Stroker stroker )
			FT_Stroker_Done;
	FT_Error		function( FT_Glyph *pglyph, FT_Stroker stroker, FT_Bool destroy )
			FT_Glyph_Stroke;
	FT_Error		function( FT_Glyph *pglyph, FT_Stroker stroker, FT_Bool inside, FT_Bool destroy )
			FT_Glyph_StrokeBorder;
	void		function( FT_GlyphSlot slot )
			FT_GlyphSlot_Embolden;
	void		function( FT_GlyphSlot slot )
			FT_GlyphSlot_Oblique;
	void		function( FTC_MruNode *plist, FTC_MruNode node )
			FTC_MruNode_Prepend;
	void		function( FTC_MruNode *plist, FTC_MruNode node )
			FTC_MruNode_Up;
	void		function( FTC_MruNode *plist, FTC_MruNode node )
			FTC_MruNode_Remove;
	void		function( FTC_MruList list, FTC_MruListClass clazz, FT_UInt max_nodes, FT_Pointer data, FT_Memory memory )
			FTC_MruList_Init;
	void		function( FTC_MruList list )
			FTC_MruList_Reset;
	void		function( FTC_MruList list )
			FTC_MruList_Done;
	FTC_MruNode		function( FTC_MruList list, FT_Pointer key )
			FTC_MruList_Find;
	FT_Error		function( FTC_MruList list, FT_Pointer key, FTC_MruNode *anode )
			FTC_MruList_New;
	FT_Error		function( FTC_MruList list, FT_Pointer key, FTC_MruNode *pnode )
			FTC_MruList_Lookup;
	void		function( FTC_MruList list, FTC_MruNode node )
			FTC_MruList_Remove;
	void		function( FTC_MruList list, FTC_MruNode_CompareFunc selection, FT_Pointer key )
			FTC_MruList_RemoveSelection;
	void		function( FTC_Node node, FTC_Manager manager )
			ftc_node_destroy;
	FT_Error		function( FTC_Cache cache )
			FTC_Cache_Init;
	void		function( FTC_Cache cache )
			FTC_Cache_Done;
	FT_Error		function( FTC_Cache cache, FT_UInt32 hash, FT_Pointer query, FTC_Node *anode )
			FTC_Cache_Lookup;
	FT_Error		function( FTC_Cache cache, FT_UInt32 hash, FT_Pointer query, FTC_Node *anode )
			FTC_Cache_NewNode;
	void		function( FTC_Cache cache, FTC_FaceID face_id )
			FTC_Cache_RemoveFaceID;
	void		function( FTC_Manager manager )
			FTC_Manager_Compress;
	FT_UInt		function( FTC_Manager manager, FT_UInt count )
			FTC_Manager_FlushN;
	FT_Error		function( FTC_Manager manager, FTC_CacheClass clazz, FTC_Cache *acache )
			FTC_Manager_RegisterCache;
	void		function( FTC_GNode node, FT_UInt gindex, FTC_Family family )
			FTC_GNode_Init;
	FT_Bool		function( FTC_GNode gnode, FTC_GQuery gquery )
			FTC_GNode_Compare;
	void		function( FTC_GNode gnode, FTC_Cache cache )
			FTC_GNode_UnselectFamily;
	void		function( FTC_GNode node, FTC_Cache cache )
			FTC_GNode_Done;
	void		function( FTC_Family family, FTC_Cache cache )
			FTC_Family_Init;
	FT_Error		function( FTC_GCache cache )
			FTC_GCache_Init;
	void		function( FTC_GCache cache )
			FTC_GCache_Done;
	FT_Error		function( FTC_Manager manager, FTC_GCacheClass clazz, FTC_GCache *acache )
			FTC_GCache_New;
	FT_Error		function( FTC_GCache cache, FT_UInt32 hash, FT_UInt gindex, FTC_GQuery query, FTC_Node *anode )
			FTC_GCache_Lookup;
	void		function( FTC_INode inode, FTC_Cache cache )
			FTC_INode_Free;
	FT_Error		function( FTC_INode *pinode, FTC_GQuery gquery, FTC_Cache cache )
			FTC_INode_New;
	FT_ULong		function( FTC_INode inode )
			FTC_INode_Weight;
	void		function( FTC_SNode snode, FTC_Cache cache )
			FTC_SNode_Free;
	FT_Error		function( FTC_SNode *psnode, FTC_GQuery gquery, FTC_Cache cache )
			FTC_SNode_New;
	FT_ULong		function( FTC_SNode inode )
			FTC_SNode_Weight;
	FT_Bool		function( FTC_SNode snode, FTC_GQuery gquery, FTC_Cache cache )
			FTC_SNode_Compare;
	char*		function( FT_Face face )
			FT_Get_X11_Font_Format;
	FT_Error		function( FT_Memory memory, FT_Long size, void* *P )
			FT_Alloc;
	FT_Error		function( FT_Memory memory, FT_Long size, void* *p )
			FT_QAlloc;
	FT_Error		function( FT_Memory memory, FT_Long current, FT_Long size, void* *P )
			FT_Realloc;
	FT_Error		function( FT_Memory memory, FT_Long current, FT_Long size, void* *p )
			FT_QRealloc;
	void		function( FT_Memory memory, void* *P )
			FT_Free;
	FT_Error		function( FT_Memory memory, FT_GlyphLoader *aloader )
			FT_GlyphLoader_New;
	FT_Error		function( FT_GlyphLoader loader )
			FT_GlyphLoader_CreateExtra;
	void		function( FT_GlyphLoader loader )
			FT_GlyphLoader_Done;
	void		function( FT_GlyphLoader loader )
			FT_GlyphLoader_Reset;
	void		function( FT_GlyphLoader loader )
			FT_GlyphLoader_Rewind;
	FT_Error		function( FT_GlyphLoader loader, FT_UInt n_points, FT_UInt n_contours )
			FT_GlyphLoader_CheckPoints;
	FT_Error		function( FT_GlyphLoader loader, FT_UInt n_subs )
			FT_GlyphLoader_CheckSubGlyphs;
	void		function( FT_GlyphLoader loader )
			FT_GlyphLoader_Prepare;
	void		function( FT_GlyphLoader loader )
			FT_GlyphLoader_Add;
	FT_Error		function( FT_GlyphLoader target, FT_GlyphLoader source )
			FT_GlyphLoader_CopyPoints;
	FT_Pointer		function( FT_ServiceDesc service_descriptors, char* service_id )
			ft_service_list_lookup;
	FT_UInt32		function( FT_UInt32 value )
			ft_highpow2;
	FT_Error		function( FT_CMap_Class clazz, FT_Pointer init_data, FT_CharMap charmap, FT_CMap *acmap )
			FT_CMap_New;
	void		function( FT_CMap cmap )
			FT_CMap_Done;
	void*		function( FT_Library library, char* mod_name )
			FT_Get_Module_Interface;
	FT_Pointer		function( FT_Module mod, char* service_id )
			ft_module_get_service;
	FT_Error		function( FT_Face face, FT_GlyphSlot *aslot )
			FT_New_GlyphSlot;
	void		function( FT_GlyphSlot slot )
			FT_Done_GlyphSlot;
	void		function( FT_GlyphSlot slot )
			ft_glyphslot_free_bitmap;
	FT_Error		function( FT_GlyphSlot slot, FT_ULong size )
			ft_glyphslot_alloc_bitmap;
	void		function( FT_GlyphSlot slot, FT_Byte* buffer )
			ft_glyphslot_set_bitmap;
	FT_Renderer		function( FT_Library library, FT_Glyph_Format format, FT_ListNode* node )
			FT_Lookup_Renderer;
	FT_Error		function( FT_Library library, FT_GlyphSlot slot, FT_Render_Mode render_mode )
			FT_Render_Glyph_Internal;
	FT_Memory		function()
			FT_New_Memory;
	void		function( FT_Memory memory )
			FT_Done_Memory;
	FT_Error		function( FT_Stream stream, char* filepathname )
			FT_Stream_Open;
	FT_Error		function( FT_Library library, FT_Open_Args* args, FT_Stream *astream )
			FT_Stream_New;
	void		function( FT_Stream stream, FT_Int external )
			FT_Stream_Free;
	void		function( FT_Stream stream, FT_Byte* base, FT_ULong size )
			FT_Stream_OpenMemory;
	void		function( FT_Stream stream )
			FT_Stream_Close;
	FT_Error		function( FT_Stream stream, FT_ULong pos )
			FT_Stream_Seek;
	FT_Error		function( FT_Stream stream, FT_Long distance )
			FT_Stream_Skip;
	FT_Long		function( FT_Stream stream )
			FT_Stream_Pos;
	FT_Error		function( FT_Stream stream, FT_Byte* buffer, FT_ULong count )
			FT_Stream_Read;
	FT_Error		function( FT_Stream stream, FT_ULong pos, FT_Byte* buffer, FT_ULong count )
			FT_Stream_ReadAt;
	FT_ULong		function( FT_Stream stream, FT_Byte* buffer, FT_ULong count )
			FT_Stream_TryRead;
	FT_Error		function( FT_Stream stream, FT_ULong count )
			FT_Stream_EnterFrame;
	void		function( FT_Stream stream )
			FT_Stream_ExitFrame;
	FT_Error		function( FT_Stream stream, FT_ULong count, FT_Byte** pbytes )
			FT_Stream_ExtractFrame;
	void		function( FT_Stream stream, FT_Byte** pbytes )
			FT_Stream_ReleaseFrame;
	FT_Char		function( FT_Stream stream )
			FT_Stream_GetChar;
	FT_Short		function( FT_Stream stream )
			FT_Stream_GetShort;
	FT_Long		function( FT_Stream stream )
			FT_Stream_GetOffset;
	FT_Long		function( FT_Stream stream )
			FT_Stream_GetLong;
	FT_Short		function( FT_Stream stream )
			FT_Stream_GetShortLE;
	FT_Long		function( FT_Stream stream )
			FT_Stream_GetLongLE;
	FT_Char		function( FT_Stream stream, FT_Error* error )
			FT_Stream_ReadChar;
	FT_Short		function( FT_Stream stream, FT_Error* error )
			FT_Stream_ReadShort;
	FT_Long		function( FT_Stream stream, FT_Error* error )
			FT_Stream_ReadOffset;
	FT_Long		function( FT_Stream stream, FT_Error* error )
			FT_Stream_ReadLong;
	FT_Short		function( FT_Stream stream, FT_Error* error )
			FT_Stream_ReadShortLE;
	FT_Long		function( FT_Stream stream, FT_Error* error )
			FT_Stream_ReadLongLE;
	FT_Error		function( FT_Stream stream, FT_Frame_Field* fields, void* structure )
			FT_Stream_ReadFields;
	FT_Int		function()
			FT_Trace_Get_Count;
	char*		function( FT_Int idx )
			FT_Trace_Get_Name;
	void		function()
			ft_debug_init;
	FT_Int32		function( FT_Int32 x )
			FT_SqrtFixed;
	FT_Int32		function( FT_Int32 x )
			FT_Sqrt32;
	void		function( FT_Library library, FT_Stream stream, char* base_name, char** new_names, FT_Long* offsets, FT_Error* errors )
			FT_Raccess_Guess;
	FT_Error		function( FT_Library library, FT_Stream stream, FT_Long rfork_offset, FT_Long *map_offset, FT_Long *rdata_pos )
			FT_Raccess_Get_HeaderInfo;
	FT_Error		function( FT_Library library, FT_Stream stream, FT_Long map_offset, FT_Long rdata_pos, FT_Long tag, FT_Long **offsets, FT_Long *count )
			FT_Raccess_Get_DataOffsets;
	void		function( FT_Validator valid, FT_Byte* base, FT_Byte* limit, FT_ValidationLevel level )
			ft_validator_init;
	FT_Int		function( FT_Validator valid )
			ft_validator_run;
	void		function( FT_Validator valid, FT_Error error )
			ft_validator_error;
}

freetype.loader.Symbol[] freetypeLinks =
[
	{ "FT_Init_FreeType",  cast(void**)& FT_Init_FreeType },
	{ "FT_Library_Version",  cast(void**)& FT_Library_Version },
	{ "FT_Done_FreeType",  cast(void**)& FT_Done_FreeType },
	{ "FT_New_Face",  cast(void**)& FT_New_Face },
	{ "FT_New_Memory_Face",  cast(void**)& FT_New_Memory_Face },
	{ "FT_Open_Face",  cast(void**)& FT_Open_Face },
	{ "FT_Attach_File",  cast(void**)& FT_Attach_File },
	{ "FT_Attach_Stream",  cast(void**)& FT_Attach_Stream },
	{ "FT_Done_Face",  cast(void**)& FT_Done_Face },
	{ "FT_Set_Char_Size",  cast(void**)& FT_Set_Char_Size },
	{ "FT_Set_Pixel_Sizes",  cast(void**)& FT_Set_Pixel_Sizes },
	{ "FT_Load_Glyph",  cast(void**)& FT_Load_Glyph },
	{ "FT_Load_Char",  cast(void**)& FT_Load_Char },
	{ "FT_Set_Transform",  cast(void**)& FT_Set_Transform },
	{ "FT_Render_Glyph",  cast(void**)& FT_Render_Glyph },
	{ "FT_Get_Kerning",  cast(void**)& FT_Get_Kerning },
	{ "FT_Get_Glyph_Name",  cast(void**)& FT_Get_Glyph_Name },
	{ "FT_Get_Postscript_Name",  cast(void**)& FT_Get_Postscript_Name },
	{ "FT_Select_Charmap",  cast(void**)& FT_Select_Charmap },
	{ "FT_Set_Charmap",  cast(void**)& FT_Set_Charmap },
	{ "FT_Get_Charmap_Index",  cast(void**)& FT_Get_Charmap_Index },
	{ "FT_Get_Char_Index",  cast(void**)& FT_Get_Char_Index },
	{ "FT_Get_First_Char",  cast(void**)& FT_Get_First_Char },
	{ "FT_Get_Next_Char",  cast(void**)& FT_Get_Next_Char },
	{ "FT_Get_Name_Index",  cast(void**)& FT_Get_Name_Index },
	{ "FT_MulDiv",  cast(void**)& FT_MulDiv },
	{ "FT_MulFix",  cast(void**)& FT_MulFix },
	{ "FT_DivFix",  cast(void**)& FT_DivFix },
	{ "FT_RoundFix",  cast(void**)& FT_RoundFix },
	{ "FT_CeilFix",  cast(void**)& FT_CeilFix },
	{ "FT_FloorFix",  cast(void**)& FT_FloorFix },
	{ "FT_Vector_Transform",  cast(void**)& FT_Vector_Transform },
	{ "FT_List_Find",  cast(void**)& FT_List_Find },
	{ "FT_List_Add",  cast(void**)& FT_List_Add },
	{ "FT_List_Insert",  cast(void**)& FT_List_Insert },
	{ "FT_List_Remove",  cast(void**)& FT_List_Remove },
	{ "FT_List_Up",  cast(void**)& FT_List_Up },
	{ "FT_List_Iterate",  cast(void**)& FT_List_Iterate },
	{ "FT_List_Finalize",  cast(void**)& FT_List_Finalize },
	{ "FT_Outline_Decompose",  cast(void**)& FT_Outline_Decompose },
	{ "FT_Outline_New",  cast(void**)& FT_Outline_New },
	{ "FT_Outline_New_Internal",  cast(void**)& FT_Outline_New_Internal },
	{ "FT_Outline_Done",  cast(void**)& FT_Outline_Done },
	{ "FT_Outline_Done_Internal",  cast(void**)& FT_Outline_Done_Internal },
	{ "FT_Outline_Check",  cast(void**)& FT_Outline_Check },
	{ "FT_Outline_Get_CBox",  cast(void**)& FT_Outline_Get_CBox },
	{ "FT_Outline_Translate",  cast(void**)& FT_Outline_Translate },
	{ "FT_Outline_Copy",  cast(void**)& FT_Outline_Copy },
	{ "FT_Outline_Transform",  cast(void**)& FT_Outline_Transform },
	{ "FT_Outline_Embolden",  cast(void**)& FT_Outline_Embolden },
	{ "FT_Outline_Reverse",  cast(void**)& FT_Outline_Reverse },
	{ "FT_Outline_Get_Bitmap",  cast(void**)& FT_Outline_Get_Bitmap },
	{ "FT_Outline_Render",  cast(void**)& FT_Outline_Render },
	{ "FT_Outline_Get_Orientation",  cast(void**)& FT_Outline_Get_Orientation },
	{ "FT_New_Size",  cast(void**)& FT_New_Size },
	{ "FT_Done_Size",  cast(void**)& FT_Done_Size },
	{ "FT_Activate_Size",  cast(void**)& FT_Activate_Size },
	{ "FT_Add_Module",  cast(void**)& FT_Add_Module },
	{ "FT_Get_Module",  cast(void**)& FT_Get_Module },
	{ "FT_Remove_Module",  cast(void**)& FT_Remove_Module },
	{ "FT_New_Library",  cast(void**)& FT_New_Library },
	{ "FT_Done_Library",  cast(void**)& FT_Done_Library },
	{ "FT_Set_Debug_Hook",  cast(void**)& FT_Set_Debug_Hook },
	{ "FT_Add_Default_Modules",  cast(void**)& FT_Add_Default_Modules },
	{ "FT_Get_Glyph",  cast(void**)& FT_Get_Glyph },
	{ "FT_Glyph_Copy",  cast(void**)& FT_Glyph_Copy },
	{ "FT_Glyph_Transform",  cast(void**)& FT_Glyph_Transform },
	{ "FT_Glyph_Get_CBox",  cast(void**)& FT_Glyph_Get_CBox },
	{ "FT_Glyph_To_Bitmap",  cast(void**)& FT_Glyph_To_Bitmap },
	{ "FT_Done_Glyph",  cast(void**)& FT_Done_Glyph },
	{ "FT_Matrix_Multiply",  cast(void**)& FT_Matrix_Multiply },
	{ "FT_Matrix_Invert",  cast(void**)& FT_Matrix_Invert },
	{ "FT_Get_Renderer",  cast(void**)& FT_Get_Renderer },
	{ "FT_Set_Renderer",  cast(void**)& FT_Set_Renderer },
	{ "FT_Has_PS_Glyph_Names",  cast(void**)& FT_Has_PS_Glyph_Names },
	{ "FT_Get_PS_Font_Info",  cast(void**)& FT_Get_PS_Font_Info },
	{ "FT_Get_PS_Font_Private",  cast(void**)& FT_Get_PS_Font_Private },
	{ "FT_Get_Sfnt_Table",  cast(void**)& FT_Get_Sfnt_Table },
	{ "FT_Load_Sfnt_Table",  cast(void**)& FT_Load_Sfnt_Table },
	{ "FT_Sfnt_Table_Info",  cast(void**)& FT_Sfnt_Table_Info },
	{ "FT_Get_CMap_Language_ID",  cast(void**)& FT_Get_CMap_Language_ID },
	{ "FT_Get_BDF_Charset_ID",  cast(void**)& FT_Get_BDF_Charset_ID },
	{ "FT_Get_BDF_Property",  cast(void**)& FT_Get_BDF_Property },
	{ "FT_Stream_OpenGzip",  cast(void**)& FT_Stream_OpenGzip },
	{ "FT_Stream_OpenLZW",  cast(void**)& FT_Stream_OpenLZW },
	{ "FT_Get_WinFNT_Header",  cast(void**)& FT_Get_WinFNT_Header },
	{ "FT_Bitmap_New",  cast(void**)& FT_Bitmap_New },
	{ "FT_Bitmap_Copy",  cast(void**)& FT_Bitmap_Copy },
	{ "FT_Bitmap_Embolden",  cast(void**)& FT_Bitmap_Embolden },
	{ "FT_Bitmap_Convert",  cast(void**)& FT_Bitmap_Convert },
	{ "FT_Bitmap_Done",  cast(void**)& FT_Bitmap_Done },
	{ "FT_Outline_Get_BBox",  cast(void**)& FT_Outline_Get_BBox },
	{ "FTC_Manager_New",  cast(void**)& FTC_Manager_New },
	{ "FTC_Manager_Reset",  cast(void**)& FTC_Manager_Reset },
	{ "FTC_Manager_Done",  cast(void**)& FTC_Manager_Done },
	{ "FTC_Manager_LookupFace",  cast(void**)& FTC_Manager_LookupFace },
	{ "FTC_Manager_LookupSize",  cast(void**)& FTC_Manager_LookupSize },
	{ "FTC_Node_Unref",  cast(void**)& FTC_Node_Unref },
	{ "FTC_Manager_RemoveFaceID",  cast(void**)& FTC_Manager_RemoveFaceID },
	{ "FTC_CMapCache_New",  cast(void**)& FTC_CMapCache_New },
	{ "FTC_CMapCache_Lookup",  cast(void**)& FTC_CMapCache_Lookup },
	{ "FTC_ImageCache_New",  cast(void**)& FTC_ImageCache_New },
	{ "FTC_ImageCache_Lookup",  cast(void**)& FTC_ImageCache_Lookup },
	{ "FTC_SBitCache_New",  cast(void**)& FTC_SBitCache_New },
	{ "FTC_SBitCache_Lookup",  cast(void**)& FTC_SBitCache_Lookup },
	{ "FT_Get_Multi_Master",  cast(void**)& FT_Get_Multi_Master },
	{ "FT_Get_MM_Var",  cast(void**)& FT_Get_MM_Var },
	{ "FT_Set_MM_Design_Coordinates",  cast(void**)& FT_Set_MM_Design_Coordinates },
	{ "FT_Set_Var_Design_Coordinates",  cast(void**)& FT_Set_Var_Design_Coordinates },
	{ "FT_Set_MM_Blend_Coordinates",  cast(void**)& FT_Set_MM_Blend_Coordinates },
	{ "FT_Set_Var_Blend_Coordinates",  cast(void**)& FT_Set_Var_Blend_Coordinates },
	{ "FT_Get_Sfnt_Name_Count",  cast(void**)& FT_Get_Sfnt_Name_Count },
	{ "FT_Get_Sfnt_Name",  cast(void**)& FT_Get_Sfnt_Name },
	{ "FT_OpenType_Validate",  cast(void**)& FT_OpenType_Validate },
	{ "FT_Sin",  cast(void**)& FT_Sin },
	{ "FT_Cos",  cast(void**)& FT_Cos },
	{ "FT_Tan",  cast(void**)& FT_Tan },
	{ "FT_Atan2",  cast(void**)& FT_Atan2 },
	{ "FT_Angle_Diff",  cast(void**)& FT_Angle_Diff },
	{ "FT_Vector_Unit",  cast(void**)& FT_Vector_Unit },
	{ "FT_Vector_Rotate",  cast(void**)& FT_Vector_Rotate },
	{ "FT_Vector_Length",  cast(void**)& FT_Vector_Length },
	{ "FT_Vector_Polarize",  cast(void**)& FT_Vector_Polarize },
	{ "FT_Vector_From_Polar",  cast(void**)& FT_Vector_From_Polar },
	{ "FT_Outline_GetInsideBorder",  cast(void**)& FT_Outline_GetInsideBorder },
	{ "FT_Outline_GetOutsideBorder",  cast(void**)& FT_Outline_GetOutsideBorder },
	{ "FT_Stroker_New",  cast(void**)& FT_Stroker_New },
	{ "FT_Stroker_Set",  cast(void**)& FT_Stroker_Set },
	{ "FT_Stroker_Rewind",  cast(void**)& FT_Stroker_Rewind },
	{ "FT_Stroker_ParseOutline",  cast(void**)& FT_Stroker_ParseOutline },
	{ "FT_Stroker_BeginSubPath",  cast(void**)& FT_Stroker_BeginSubPath },
	{ "FT_Stroker_EndSubPath",  cast(void**)& FT_Stroker_EndSubPath },
	{ "FT_Stroker_LineTo",  cast(void**)& FT_Stroker_LineTo },
	{ "FT_Stroker_ConicTo",  cast(void**)& FT_Stroker_ConicTo },
	{ "FT_Stroker_CubicTo",  cast(void**)& FT_Stroker_CubicTo },
	{ "FT_Stroker_GetBorderCounts",  cast(void**)& FT_Stroker_GetBorderCounts },
	{ "FT_Stroker_ExportBorder",  cast(void**)& FT_Stroker_ExportBorder },
	{ "FT_Stroker_GetCounts",  cast(void**)& FT_Stroker_GetCounts },
	{ "FT_Stroker_Export",  cast(void**)& FT_Stroker_Export },
	{ "FT_Stroker_Done",  cast(void**)& FT_Stroker_Done },
	{ "FT_Glyph_Stroke",  cast(void**)& FT_Glyph_Stroke },
	{ "FT_Glyph_StrokeBorder",  cast(void**)& FT_Glyph_StrokeBorder },
	{ "FT_GlyphSlot_Embolden",  cast(void**)& FT_GlyphSlot_Embolden },
	{ "FT_GlyphSlot_Oblique",  cast(void**)& FT_GlyphSlot_Oblique },
	{ "FTC_MruNode_Prepend",  cast(void**)& FTC_MruNode_Prepend },
	{ "FTC_MruNode_Up",  cast(void**)& FTC_MruNode_Up },
	{ "FTC_MruNode_Remove",  cast(void**)& FTC_MruNode_Remove },
	{ "FTC_MruList_Init",  cast(void**)& FTC_MruList_Init },
	{ "FTC_MruList_Reset",  cast(void**)& FTC_MruList_Reset },
	{ "FTC_MruList_Done",  cast(void**)& FTC_MruList_Done },
	{ "FTC_MruList_Find",  cast(void**)& FTC_MruList_Find },
	{ "FTC_MruList_New",  cast(void**)& FTC_MruList_New },
	{ "FTC_MruList_Lookup",  cast(void**)& FTC_MruList_Lookup },
	{ "FTC_MruList_Remove",  cast(void**)& FTC_MruList_Remove },
	{ "FTC_MruList_RemoveSelection",  cast(void**)& FTC_MruList_RemoveSelection },
	{ "ftc_node_destroy",  cast(void**)& ftc_node_destroy },
	{ "FTC_Cache_Init",  cast(void**)& FTC_Cache_Init },
	{ "FTC_Cache_Done",  cast(void**)& FTC_Cache_Done },
	{ "FTC_Cache_Lookup",  cast(void**)& FTC_Cache_Lookup },
	{ "FTC_Cache_NewNode",  cast(void**)& FTC_Cache_NewNode },
	{ "FTC_Cache_RemoveFaceID",  cast(void**)& FTC_Cache_RemoveFaceID },
	{ "FTC_Manager_Compress",  cast(void**)& FTC_Manager_Compress },
	{ "FTC_Manager_FlushN",  cast(void**)& FTC_Manager_FlushN },
	{ "FTC_Manager_RegisterCache",  cast(void**)& FTC_Manager_RegisterCache },
	{ "FTC_GNode_Init",  cast(void**)& FTC_GNode_Init },
	{ "FTC_GNode_Compare",  cast(void**)& FTC_GNode_Compare },
	{ "FTC_GNode_UnselectFamily",  cast(void**)& FTC_GNode_UnselectFamily },
	{ "FTC_GNode_Done",  cast(void**)& FTC_GNode_Done },
	{ "FTC_Family_Init",  cast(void**)& FTC_Family_Init },
	{ "FTC_GCache_Init",  cast(void**)& FTC_GCache_Init },
	{ "FTC_GCache_Done",  cast(void**)& FTC_GCache_Done },
	{ "FTC_GCache_New",  cast(void**)& FTC_GCache_New },
	{ "FTC_GCache_Lookup",  cast(void**)& FTC_GCache_Lookup },
	{ "FTC_INode_Free",  cast(void**)& FTC_INode_Free },
	{ "FTC_INode_New",  cast(void**)& FTC_INode_New },
	{ "FTC_INode_Weight",  cast(void**)& FTC_INode_Weight },
	{ "FTC_SNode_Free",  cast(void**)& FTC_SNode_Free },
	{ "FTC_SNode_New",  cast(void**)& FTC_SNode_New },
	{ "FTC_SNode_Weight",  cast(void**)& FTC_SNode_Weight },
	{ "FTC_SNode_Compare",  cast(void**)& FTC_SNode_Compare },
	{ "FT_Get_X11_Font_Format",  cast(void**)& FT_Get_X11_Font_Format },
	{ "FT_Alloc",  cast(void**)& FT_Alloc },
	{ "FT_QAlloc",  cast(void**)& FT_QAlloc },
	{ "FT_Realloc",  cast(void**)& FT_Realloc },
	{ "FT_QRealloc",  cast(void**)& FT_QRealloc },
	{ "FT_Free",  cast(void**)& FT_Free },
	{ "FT_GlyphLoader_New",  cast(void**)& FT_GlyphLoader_New },
	{ "FT_GlyphLoader_CreateExtra",  cast(void**)& FT_GlyphLoader_CreateExtra },
	{ "FT_GlyphLoader_Done",  cast(void**)& FT_GlyphLoader_Done },
	{ "FT_GlyphLoader_Reset",  cast(void**)& FT_GlyphLoader_Reset },
	{ "FT_GlyphLoader_Rewind",  cast(void**)& FT_GlyphLoader_Rewind },
	{ "FT_GlyphLoader_CheckPoints",  cast(void**)& FT_GlyphLoader_CheckPoints },
	{ "FT_GlyphLoader_CheckSubGlyphs",  cast(void**)& FT_GlyphLoader_CheckSubGlyphs },
	{ "FT_GlyphLoader_Prepare",  cast(void**)& FT_GlyphLoader_Prepare },
	{ "FT_GlyphLoader_Add",  cast(void**)& FT_GlyphLoader_Add },
	{ "FT_GlyphLoader_CopyPoints",  cast(void**)& FT_GlyphLoader_CopyPoints },
	{ "ft_service_list_lookup",  cast(void**)& ft_service_list_lookup },
	{ "ft_highpow2",  cast(void**)& ft_highpow2 },
	{ "FT_CMap_New",  cast(void**)& FT_CMap_New },
	{ "FT_CMap_Done",  cast(void**)& FT_CMap_Done },
	{ "FT_Get_Module_Interface",  cast(void**)& FT_Get_Module_Interface },
	{ "ft_module_get_service",  cast(void**)& ft_module_get_service },
	{ "FT_New_GlyphSlot",  cast(void**)& FT_New_GlyphSlot },
	{ "FT_Done_GlyphSlot",  cast(void**)& FT_Done_GlyphSlot },
	{ "ft_glyphslot_free_bitmap",  cast(void**)& ft_glyphslot_free_bitmap },
	{ "ft_glyphslot_alloc_bitmap",  cast(void**)& ft_glyphslot_alloc_bitmap },
	{ "ft_glyphslot_set_bitmap",  cast(void**)& ft_glyphslot_set_bitmap },
	{ "FT_Lookup_Renderer",  cast(void**)& FT_Lookup_Renderer },
	{ "FT_Render_Glyph_Internal",  cast(void**)& FT_Render_Glyph_Internal },
	{ "FT_New_Memory",  cast(void**)& FT_New_Memory },
	{ "FT_Done_Memory",  cast(void**)& FT_Done_Memory },
	{ "FT_Stream_Open",  cast(void**)& FT_Stream_Open },
	{ "FT_Stream_New",  cast(void**)& FT_Stream_New },
	{ "FT_Stream_Free",  cast(void**)& FT_Stream_Free },
	{ "FT_Stream_OpenMemory",  cast(void**)& FT_Stream_OpenMemory },
	{ "FT_Stream_Close",  cast(void**)& FT_Stream_Close },
	{ "FT_Stream_Seek",  cast(void**)& FT_Stream_Seek },
	{ "FT_Stream_Skip",  cast(void**)& FT_Stream_Skip },
	{ "FT_Stream_Pos",  cast(void**)& FT_Stream_Pos },
	{ "FT_Stream_Read",  cast(void**)& FT_Stream_Read },
	{ "FT_Stream_ReadAt",  cast(void**)& FT_Stream_ReadAt },
	{ "FT_Stream_TryRead",  cast(void**)& FT_Stream_TryRead },
	{ "FT_Stream_EnterFrame",  cast(void**)& FT_Stream_EnterFrame },
	{ "FT_Stream_ExitFrame",  cast(void**)& FT_Stream_ExitFrame },
	{ "FT_Stream_ExtractFrame",  cast(void**)& FT_Stream_ExtractFrame },
	{ "FT_Stream_ReleaseFrame",  cast(void**)& FT_Stream_ReleaseFrame },
	{ "FT_Stream_GetChar",  cast(void**)& FT_Stream_GetChar },
	{ "FT_Stream_GetShort",  cast(void**)& FT_Stream_GetShort },
	{ "FT_Stream_GetOffset",  cast(void**)& FT_Stream_GetOffset },
	{ "FT_Stream_GetLong",  cast(void**)& FT_Stream_GetLong },
	{ "FT_Stream_GetShortLE",  cast(void**)& FT_Stream_GetShortLE },
	{ "FT_Stream_GetLongLE",  cast(void**)& FT_Stream_GetLongLE },
	{ "FT_Stream_ReadChar",  cast(void**)& FT_Stream_ReadChar },
	{ "FT_Stream_ReadShort",  cast(void**)& FT_Stream_ReadShort },
	{ "FT_Stream_ReadOffset",  cast(void**)& FT_Stream_ReadOffset },
	{ "FT_Stream_ReadLong",  cast(void**)& FT_Stream_ReadLong },
	{ "FT_Stream_ReadShortLE",  cast(void**)& FT_Stream_ReadShortLE },
	{ "FT_Stream_ReadLongLE",  cast(void**)& FT_Stream_ReadLongLE },
	{ "FT_Stream_ReadFields",  cast(void**)& FT_Stream_ReadFields },
	{ "FT_Trace_Get_Count",  cast(void**)& FT_Trace_Get_Count },
	{ "FT_Trace_Get_Name",  cast(void**)& FT_Trace_Get_Name },
	{ "ft_debug_init",  cast(void**)& ft_debug_init },
	{ "FT_SqrtFixed",  cast(void**)& FT_SqrtFixed },
	{ "FT_Sqrt32",  cast(void**)& FT_Sqrt32 },
	{ "FT_Raccess_Guess",  cast(void**)& FT_Raccess_Guess },
	{ "FT_Raccess_Get_HeaderInfo",  cast(void**)& FT_Raccess_Get_HeaderInfo },
	{ "FT_Raccess_Get_DataOffsets",  cast(void**)& FT_Raccess_Get_DataOffsets },
	{ "ft_validator_init",  cast(void**)& ft_validator_init },
	{ "ft_validator_run",  cast(void**)& ft_validator_run },
	{ "ft_validator_error",  cast(void**)& ft_validator_error }
];