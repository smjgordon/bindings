/*
*	Glade bindings by John Demme (me@teqdruid.com)
*/

module glade;

private import gtk;

public {

	/* From glade-init.h */
	/* handle dynamic loading of libglade extensions */
	extern(C) void glade_require(gchar *library);
	extern(C) void glade_provide(gchar *library);

	/* From glade-xml.h */
	/* Hack... but who cares? */
	typedef void GladeXML;
	typedef void GladeXMLClass;
	typedef void GladeXMLPrivate;

	extern(C) GType glade_xml_get_type ();
	extern(C) GladeXML* glade_xml_new (char *fname, char *root, char *domain);
	extern(C) GladeXML* glade_xml_new_from_buffer     (char *buffer, int size, char *root, char *domain);
	extern(C) gboolean  glade_xml_construct           (GladeXML *self, char *fname, char *root, char *domain);

	extern(C) void glade_xml_signal_connect (GladeXML *self, char *handlername, GCallback func);
	extern(C) void glade_xml_signal_connect_data (GladeXML *self, char *handlername, GCallback func, gpointer user_data);
	/*
	* use gmodule to connect signals automatically.  Basically a symbol with
	* the name of the signal handler is searched for, and that is connected to
	* the associated symbols.  So setting gtk_main_quit as a signal handler
	* for the destroy signal of a window will do what you expect.
	*/
	extern(C) void glade_xml_signal_autoconnect (GladeXML *self);

	/* if the gtk_signal_connect_object behaviour is required, connect_object
	* will point to the object, otherwise it will be NULL.
	*/
	typedef void (*GladeXMLConnectFunc) (gchar *handler_name,
					GObject *object,
					gchar *signal_name,
					gchar *signal_data,
					GObject *connect_object,
					gboolean after,
					gpointer user_data);

	/*
	* These two are to make it easier to use libglade with an interpreted
	* language binding.
	*/
	extern(C) void       glade_xml_signal_connect_full     (GladeXML *self,
						gchar *handler_name,
						GladeXMLConnectFunc func,
						gpointer user_data);

	extern(C) void       glade_xml_signal_autoconnect_full (GladeXML *self,
						GladeXMLConnectFunc func,
						gpointer user_data);


	extern(C) GtkWidget *glade_xml_get_widget              (GladeXML *self,
						char *name);
	extern(C) GList     *glade_xml_get_widget_prefix       (GladeXML *self,
						char *name);

	extern(C) gchar     *glade_xml_relative_file           (GladeXML *self,
						gchar *filename);

	/* don't free the results of these two ... */
	extern(C) char *glade_get_widget_name      (GtkWidget *widget);
	GladeXML   *glade_get_widget_tree      (GtkWidget *widget);


	/* interface for changing the custom widget handling */
	typedef GtkWidget *(* GladeXMLCustomWidgetHandler) (GladeXML *xml,
							gchar *func_name,
							gchar *name,
							gchar *string1,
							gchar *string2,
							gint int1,
							gint int2,
							gpointer user_data);

	extern(C) void glade_set_custom_handler(GladeXMLCustomWidgetHandler handler,
				gpointer user_data);


	/* From glade-parser.h */
	typedef _GladeProperty GladeProperty;
	struct _GladeProperty {
	gchar *name;
	gchar *value;
	}

	typedef _GladeSignalInfo GladeSignalInfo;
	struct _GladeSignalInfo {
	gchar *name;
	gchar *handler;
	gchar *object; /* NULL if this isn't a connect_object signal */
	guint after;
	}

	typedef _GladeAtkActionInfo GladeAtkActionInfo;
	struct _GladeAtkActionInfo {
	gchar *action_name;
	gchar *description;
	}

	typedef _GladeAtkRelationInfo GladeAtkRelationInfo;
	struct _GladeAtkRelationInfo {
	gchar *target;
	gchar *type;
	}

	typedef _GladeAccelInfo GladeAccelInfo;
	struct _GladeAccelInfo {
	guint key;
	GdkModifierType modifiers;
	gchar *signal;
	}

	typedef _GladeWidgetInfo GladeWidgetInfo;
	typedef _GladeChildInfo GladeChildInfo;

	struct _GladeWidgetInfo {
	GladeWidgetInfo *parent;

	gchar *classname;
	gchar *name;

	GladeProperty *properties;
	guint n_properties;

	GladeProperty *atk_props;
	guint n_atk_props;

	GladeSignalInfo *signals;
	guint n_signals;

	GladeAtkActionInfo *atk_actions;
	guint n_atk_actions;

	GladeAtkRelationInfo *relations;
	guint n_relations;

	GladeAccelInfo *accels;
	guint n_accels;

	GladeChildInfo *children;
	guint n_children;
	}

	struct _GladeChildInfo {
	GladeProperty *properties;
	guint n_properties;

	GladeWidgetInfo *child;
	gchar *internal_child;
	}

	typedef _GladeInterface GladeInterface;
	struct _GladeInterface {
	gchar **requires;
	guint n_requires;

	GladeWidgetInfo **toplevels;
	guint n_toplevels;

	GHashTable *names;

	GHashTable *strings;
	}

	/* the actual functions ... */
	extern(C) GladeInterface *glade_parser_parse_file   (gchar *file,
						gchar *domain);
	extern(C) GladeInterface *glade_parser_parse_buffer (gchar *buffer, gint len,
						gchar *domain);
	extern(C) void            glade_interface_destroy   (GladeInterface *Interface);

	extern(C) void            glade_interface_dump      (GladeInterface *Interface,
						gchar *filename);

	/* From glade-build.h */

	/* create a new widget of some type.  Don't parse `standard' widget options */
	typedef GtkWidget *(* GladeNewFunc)               (GladeXML *xml,
							GType widget_type,
							GladeWidgetInfo *info);
	/* call glade_xml_build_widget on each child node, and pack in self */
	typedef void       (* GladeBuildChildrenFunc)     (GladeXML *xml,
							GtkWidget *parent,
							GladeWidgetInfo *info);
	typedef GtkWidget *(* GladeFindInternalChildFunc) (GladeXML *xml,
							GtkWidget *parent,
							gchar *childname);

	typedef void       (* GladeApplyCustomPropFunc)   (GladeXML *xml,
							GtkWidget *widget,
							gchar *propname,
							gchar *value);

	/* register handlers for a widget */
	extern(C) void glade_register_widget(GType type,
				GladeNewFunc new_func,
				GladeBuildChildrenFunc build_children,
				GladeFindInternalChildFunc find_internal_child);

	/* register a custom handler for a property (that may not have an
	* associated gobject property.  Works in conjunction with
	* glade_standard_build_widget. */
	extern(C) void glade_register_custom_prop(GType type,
					gchar *prop_name,
					GladeApplyCustomPropFunc apply_prop);

	/* set the current toplevel widget while building (use NULL to unset) */
	extern(C) void       glade_xml_set_toplevel(GladeXML *xml, GtkWindow *window);

	/* make sure that xml->priv->accel_group is a valid AccelGroup */
	extern(C) GtkAccelGroup *glade_xml_ensure_accel(GladeXML *xml);

	extern(C) void glade_xml_handle_widget_prop(GladeXML *self, GtkWidget *widget,
					gchar *prop_name,
					gchar *value_name);

	extern(C) void glade_xml_set_packing_property (GladeXML   *self,
					GtkWidget  *parent, GtkWidget  *child,
					char *name,   char *value);

	/* this function is called to build the interface by GladeXML */
	extern(C) GtkWidget *glade_xml_build_widget(GladeXML *self, GladeWidgetInfo *info);

	/* this function is used to get a pointer to the internal child of a
	* container widget.  It would generally be called by the
	* build_children callback for any children with the internal_child
	* name set. */
	extern(C) void glade_xml_handle_internal_child(GladeXML *self, GtkWidget *parent,
					GladeChildInfo *child_info);

	/* This function performs half of what glade_xml_build_widget does.  It is
	* useful when the widget has already been created.  Usually it would not
	* have any use at all. */
	extern(C) void       glade_xml_set_common_params(GladeXML *self,
					GtkWidget *widget,
					GladeWidgetInfo *info);

	extern(C) gboolean glade_xml_set_value_from_string (GladeXML *xml,
						GParamSpec *pspec,
						gchar *string,
						GValue *value);

	extern(C) GtkWidget *glade_standard_build_widget(GladeXML *xml, GType widget_type,
					GladeWidgetInfo *info);

	/* A standard child building routine that can be used in widget builders */
	extern(C) void glade_standard_build_children(GladeXML *self, GtkWidget *parent,
					GladeWidgetInfo *info);

	/* this is a wrapper for gtk_type_enum_find_value, that just returns the
	* integer value for the enum */
	extern(C) gint  glade_enum_from_string(GType type, char *string);
	extern(C) guint glade_flags_from_string(GType type, char *string);

	/* the module dynamic loading interface ... */

	/* increase this when there is a binary incompatible change in the
	* libglade module API */
	extern(C) gchar *glade_module_check_version(gint Version);
}