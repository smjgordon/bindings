/*
  FUSE: Filesystem in Userspace
  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>

  This program can be distributed under the terms of the GNU LGPLv2.
  See the file COPYING.LIB.
*/

/** @file */

/+
#if !defined(_FUSE_H_) && !defined(_FUSE_LOWLEVEL_H_)
#error "Never include <fuse_common.h> directly; use <fuse.h> or <fuse_lowlevel.h> instead."
#endif
+/

module fuse.common;

public import fuse.opt;
import tango.stdc.stdint;
import tango.stdc.posix.time;

version (darwin) version = FreeBSD_10;
version (freebsd) version = FreeBSD_10;

/** Major version of FUSE library interface */
const FUSE_MAJOR_VERSION = 2;

/** Minor version of FUSE library interface */
const FUSE_MINOR_VERSION = 7;

int FUSE_MAKE_VERSION(int maj, int min)  { return ((maj) * 10 + (min)); }
const FUSE_VERSION = FUSE_MAKE_VERSION(FUSE_MAJOR_VERSION, FUSE_MINOR_VERSION);

/* This interface uses 64 bit off_t */
/+
#if _FILE_OFFSET_BITS != 64
#error Please add -D_FILE_OFFSET_BITS=64 to your compile flags!
#endif
+/

extern (C):

version (FreeBSD_10) { /+ #if (__FreeBSD__ >= 10) +/

import tango.stdc.posix.sys.stat;


/* The following bits must be in lockstep with those in fuse_lowlevel.h */

int32_t SETATTR_WANTS_MODE(setattr_x_t* attr)    { return (attr.valid & (1 << 0)); }
int32_t SETATTR_WANTS_UID(setattr_x_t* attr)      { return (attr.valid & (1 << 1)); }
int32_t SETATTR_WANTS_GID(setattr_x_t* attr)      { return (attr.valid & (1 << 2)); }
int32_t SETATTR_WANTS_SIZE(setattr_x_t* attr) { return (attr.valid & (1 << 3)); }
int32_t SETATTR_WANTS_ACCTIME(setattr_x_t* attr)  { return (attr.valid & (1 << 4)); }
int32_t SETATTR_WANTS_MODTIME(setattr_x_t* attr)  { return (attr.valid & (1 << 5)); }
int32_t SETATTR_WANTS_CRTIME(setattr_x_t* attr)   { return (attr.valid & (1 << 28)); }
int32_t SETATTR_WANTS_CHGTIME(setattr_x_t* attr)  { return (attr.valid & (1 << 29)); }
int32_t SETATTR_WANTS_BKUPTIME(setattr_x_t* attr) { return (attr.valid & (1 << 30)); }
int32_t SETATTR_WANTS_FLAGS(setattr_x_t* attr)    { return (attr.valid & (1 << 31)); }

struct setattr_x_t {
	int32_t valid;
	mode_t mode;
	uid_t uid;
	gid_t gid;
	off_t size;
	/+ struct +/ timespec acctime;
    /+ struct +/ timespec modtime;
    /+ struct +/ timespec crtime;
    /+ struct +/ timespec chgtime;
    /+ struct +/ timespec bkuptime;
	uint32_t flags;
};

} /* __FreeBSD__ >= 10 */

/**
 * Information about open files
 *
 * Changed in version 2.5
 */
struct fuse_file_info {
	/** Open flags.	 Available in open() and release() */
	int flags;

	/** Old file handle, don't use */
	/+ unsigned long +/  uint fh_old;

	/** In case of a write operation indicates if this was caused by a
	    writepage */
	int writepage;

    uint _bitfield;
	/** Can be filled in by open, to use direct I/O on this file.
	    Introduced in version 2.4 */
    void direct_io(uint val) { _bitfield &= ~(1 << 31); _bitfield |= ~(1 << 31); }
    uint direct_io() { return (_bitfield >> 31) & 0x1; }

	/** Can be filled in by open, to indicate, that cached file data
	    need not be invalidated.  Introduced in version 2.4 */
    void keep_cache(uint val) { _bitfield &= ~(1 << 30); _bitfield |= ~(1 << 30); }
    uint keep_cache() { return (_bitfield >> 30) & 0x1; }

	/** Indicates a flush operation.  Set in flush operation, also
	    maybe set in highlevel lock operation and lowlevel release
	    operation.	Introduced in version 2.6 */
    void flush(uint val) { _bitfield &= ~(1 << 29); _bitfield |= ~(1 << 29); }
    uint flush() { return (_bitfield >> 29) & 0x1; }

version (FreeBSD_10) { /+ #if (__FreeBSD__ >= 10) +/
	/** Padding.  Do not use*/
	/+ unsigned int padding : 27; +/
    void purge_attr(uint val) { _bitfield &= ~(1 << 1); _bitfield |= ~(1 << 1); }
    uint purge_attr() { return (_bitfield >> 1) & 0x1; }
    void purge_ubc(uint val) { _bitfield &= ~(1 << 0); _bitfield |= ~(1 << 0); }
    uint purge_ubc() { return (_bitfield >> 0) & 0x1; }
} else {
	/** Padding.  Do not use*/
	/+ unsigned int padding : 29; +/
}

	/** File handle.  May be filled in by filesystem in open().
	    Available in all other file operations */
	uint64_t fh;

	/** Lock owner id.  Available in locking operations and flush */
	uint64_t lock_owner;
};

/**
 * Connection information, passed to the ->init() method
 *
 * Some of the elements are read-write, these can be changed to
 * indicate the value requested by the filesystem.  The requested
 * value must usually be smaller than the indicated value.
 */
struct fuse_conn_info {
	/**
	 * Major version of the protocol (read-only)
	 */
	/+ unsigned +/ uint proto_major;

	/**
	 * Minor version of the protocol (read-only)
	 */
	/+ unsigned +/  uint proto_minor;

	/**
	 * Is asynchronous read supported (read-write)
	 */
	/+ unsigned +/ uint async_read;

	/**
	 * Maximum size of the write buffer
	 */
	/+ unsigned +/ uint max_write;

	/**
	 * Maximum readahead
	 */
	/+ unsigned +/ uint max_readahead;

	/**
	 * For future use.
	 */
version (FreeBSD_10) { /+ #if (__FreeBSD__ >= 10) +/
	static struct enable_t {
        ubyte _bitfield;
        void case_insensitive(ubyte val) { _bitfield &= ~(1 << 7); _bitfield |= ~(1 << 7); }
        ubyte case_insensitive() { return (_bitfield >> 7) & 0x1; }
        void setvolname(ubyte val) { _bitfield &= ~(1 << 6); _bitfield |= ~(1 << 6); }
        ubyte setvolname() { return (_bitfield >> 6) & 0x1; }
        void xtimes(ubyte val) { _bitfield &= ~(1 << 5); _bitfield |= ~(1 << 5); }
        ubyte xtimes() { return (_bitfield >> 5) & 0x1; }
	}
    enable_t enable;
	/+ unsigned +/ uint reserved[26];
} else {
	/+ unsigned +/ uint reserved[27];
} /* __FreeBSD__ >= 10 */
}

//version (FreeBSD_10) { /+ #if (__FreeBSD__ >= 10) +/
void FUSE_ENABLE_SETVOLNAME(fuse_conn_info* i)	{ i.enable.setvolname = 1; }
void FUSE_ENABLE_XTIMES(fuse_conn_info* i)		{ i.enable.xtimes = 1; }
//} /* __FreeBSD__ >= 10 */

struct fuse_session;
struct fuse_chan;

/**
 * Create a FUSE mountpoint
 *
 * Returns a control file descriptor suitable for passing to
 * fuse_new()
 *
 * @param mountpoint the mount point path
 * @param args argument vector
 * @return the communication channel on success, NULL on failure
 */
/+ struct +/ fuse_chan *fuse_mount(/+ const +/ char *mountpoint, /+ struct +/ fuse_args *args);

/**
 * Umount a FUSE mountpoint
 *
 * @param mountpoint the mount point path
 * @param ch the communication channel
 */
void fuse_unmount(/+ const +/ char *mountpoint, /+ struct +/ fuse_chan *ch);

/**
 * Parse common options
 *
 * The following options are parsed:
 *
 *   '-f'	     foreground
 *   '-d' '-odebug'  foreground, but keep the debug option
 *   '-s'	     single threaded
 *   '-h' '--help'   help
 *   '-ho'	     help without header
 *   '-ofsname=..'   file system name, if not present, then set to the program
 *		     name
 *
 * All parameters may be NULL
 *
 * @param args argument vector
 * @param mountpoint the returned mountpoint, should be freed after use
 * @param multithreaded set to 1 unless the '-s' option is present
 * @param foreground set to 1 if one of the relevant options is present
 * @return 0 on success, -1 on failure
 */
int fuse_parse_cmdline(/+ struct +/ fuse_args *args, char **mountpoint,
		       int *multithreaded, int *foreground);

/**
 * Go into the background
 *
 * @param foreground if true, stay in the foreground
 * @return 0 on success, -1 on failure
 */
int fuse_daemonize(int foreground);

/**
 * Get the version of the library
 *
 * @return the version
 */
int fuse_version(/+void+/);

/* ----------------------------------------------------------- *
 * Signal handling					       *
 * ----------------------------------------------------------- */

/**
 * Exit session on HUP, TERM and INT signals and ignore PIPE signal
 *
 * Stores session in a global variable.	 May only be called once per
 * process until fuse_remove_signal_handlers() is called.
 *
 * @param se the session to exit
 * @return 0 on success, -1 on failure
 */
int fuse_set_signal_handlers(/+ struct +/ fuse_session *se);

/**
 * Restore default signal handlers
 *
 * Resets global session.  After this fuse_set_signal_handlers() may
 * be called again.
 *
 * @param se the same session as given in fuse_set_signal_handlers()
 */
void fuse_remove_signal_handlers(/+ struct +/ fuse_session *se);

/* ----------------------------------------------------------- *
 * Compatibility stuff					       *
 * ----------------------------------------------------------- */

/+
#if FUSE_USE_VERSION < 26
#    ifdef __FreeBSD__
#	 if FUSE_USE_VERSION < 25
#	     error On FreeBSD API version 25 or greater must be used
#	 endif
#    endif
#    include "fuse_common_compat.h"
#    undef FUSE_MINOR_VERSION
#    undef fuse_main
#    define fuse_unmount fuse_unmount_compat22
#    if FUSE_USE_VERSION == 25
#	 define FUSE_MINOR_VERSION 5
#	 define fuse_mount fuse_mount_compat25
#    elif FUSE_USE_VERSION == 24 || FUSE_USE_VERSION == 22
#	 define FUSE_MINOR_VERSION 4
#	 define fuse_mount fuse_mount_compat22
#    elif FUSE_USE_VERSION == 21
#	 define FUSE_MINOR_VERSION 1
#	 define fuse_mount fuse_mount_compat22
#    elif FUSE_USE_VERSION == 11
#	 warning Compatibility with API version 11 is deprecated
#	 undef FUSE_MAJOR_VERSION
#	 define FUSE_MAJOR_VERSION 1
#	 define FUSE_MINOR_VERSION 1
#	 define fuse_mount fuse_mount_compat1
#    else
#	 error Compatibility with API version other than 21, 22, 24, 25 and 11 not supported
#    endif
#endif
+/
