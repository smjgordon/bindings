//
// libarchive modules for D
// Written by Anders Bergh <anders1@gmail.com>
// Released into the public domain
//

module libarchive.types;

// This is the only stuff that depends on Tango. If you want to use
// libarchive together with Phobos, either A) alias the types yourself
// or B) find the proper Phobos modules and import them here
version (Tango)
{
	version (Posix)
	{
		public import tango.stdc.posix.sys.types;
		public import tango.stdc.posix.sys.stat;
	}

	public import tango.stdc.stdint;
}

version (Posix)
{
}
else version (Windows)
{
	// TODO: Check these, I just did these for the ones that were missing...
	// I'm not really supporting Windows anyway
	alias int uid_t;
	alias int gid_t;
	alias int ssize_t;
	alias int dev_t;
	alias int off_t;
	alias int ino_t;
	alias int stat_t;
	alias int time_t;
	alias int mode_t;
}
else
{
	static assert(0, `No support for this platform!`);
}