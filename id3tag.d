// ID3 Tag retrieval D module.
// written by James Dunne

// (c) Copyright James Dunne 2004, 2005
// 06 Dec. 2004

module	id3tag;

import	std.stream;
import	std.intrinsic;
import	std.string;

// A very simple tag structure, only
// concerned with simple song details.
struct ID3Tag {
	// 1 for ID3v1, 2 for ID3v2
	int		id3version;
	// The common fields:
	char[]	title;
	char[]	artist;
	char[]	album;
	int		year;
	int		track, tracks;
	char[]	genre;
};

// Exception thrown by readID3Tag():
class ID3Exception : Exception {
	this(char[] msg) {
		super(msg);
	}
}

// Reads an ID3 tag from an MP3 stream.
// Stream must be at least both seekable and readable.

// This function returns an ID3Tag structure representing the
// ID3 information read in.  ID3v2 tag is searched for first,
// and if not found, ID3v1 is searched for.  If neither is found
// the function returns 'null'.

ID3Tag* readID3Tag(Stream stream) {
	ID3Tag*	tag;

	// Read a string from a stream:
	char[] readString(Stream stream, int taglen) {
		// Read the string:
		char*	str = new char[taglen];
		stream.readBlock(cast(void*)str, taglen);

		return str[0 .. taglen].dup;
	}

	// Test stream properties:
	if (!stream.seekable) throw new ID3Exception("Stream must be seekable");
	if (!stream.readable) throw new ID3Exception("Stream must be readable");

	char*	blk = new char[4];
	const char[3]	head = "ID3";

	// Look for an ID3 v2 tag at the start of the stream:
	stream.seek(0x00, SeekPos.Set);
	stream.readBlock(cast(void*)blk, 4);

	if ((blk[0 .. 3] == head) && (blk[3] == 3)) {
		// The code below is based totally on my hacking ability, and I know it
		// to be incorrect for certain ID3v2 layouts.  I have yet to hack out
		// that format.

		bool	done = false;
		uint	taglen;
		ushort	dummy;

		tag = new ID3Tag;
		tag.id3version = 2;

		// Skip 6 bytes:
		stream.seek(0x06, SeekPos.Current);

		// Keep reading blocks of 4-character identifiers:
		while (!done) {
			// Read the block identifier:
			stream.readBlock(cast(void*)blk, 4);
			if (blk[0] == 0) break;

			// Read the length:
			stream.readBlock(cast(void*)&taglen, 4);
			version (LittleEndian) taglen = bswap(taglen);
			// Read 2 dumb bytes:
			stream.readBlock(cast(void*)&dummy, 2);
			// dummy should be byte-swapped also (only as a ushort)
			// however, it is never used.

			// Now, what to do with the string?
			switch (blk[0 .. 4]) {
				// Song title:
				case "TIT2":
					stream.seek(1, SeekPos.Current); --taglen;
					tag.title = readString(stream, taglen);
					break;
				// Song artist:
				case "TPE1", "TPE2":
					stream.seek(1, SeekPos.Current); --taglen;
					tag.artist = readString(stream, taglen);
					break;
				// Album title:
				case "TALB":
					stream.seek(1, SeekPos.Current); --taglen;
					tag.album = readString(stream, taglen);
					break;
				// Song genre:
				case "TCON":
					stream.seek(1, SeekPos.Current); --taglen;
					tag.genre = readString(stream, taglen);
					break;
				// Song track:  (can also be "n/N" format where n is track and N is tracks)
				case "TRCK":
					stream.seek(1, SeekPos.Current); --taglen;
					char[][] trkstrs = split(readString(stream, taglen), "/");
					tag.track = atoi(trkstrs[0]);
					// If no / separator, just set a dumb default for maxtracks:
					if (trkstrs.length == 2)
						tag.tracks = atoi(trkstrs[1]);
					else
						tag.tracks = 0;
					break;
				// Album year release:
				case "TYER":
					stream.seek(1, SeekPos.Current); --taglen;
					tag.year = atoi(readString(stream, taglen));
					break;

				// Dummy fields ignored:
				default:
					stream.seek(taglen, SeekPos.Current);
					break;
			}
		}
		return tag;

	} else {

		// Look for an ID3 v1 tag 0x80 bytes from end of stream:
		stream.seek(-0x80, SeekPos.End);
		stream.readBlock(cast(void*)blk, 3);

		if (blk[0 .. 3] == "TAG") {
			char*	str = new char[30];
			ubyte	trk = 0;

			tag = new ID3Tag;
			tag.id3version = 1;

			// All fields are 30 characters long:
			stream.readBlock(cast(void*)str, 30);
			tag.title = strip(std.string.toString(str));

			str = new char[30];
			stream.readBlock(cast(void*)str, 30);
			tag.artist = strip(std.string.toString(str));

			str = new char[30];
			stream.readBlock(cast(void*)str, 30);
			tag.album = strip(std.string.toString(str));

			str = new char[4];
			stream.readBlock(cast(void*)str, 4);
			tag.year = atoi(str[0 .. 4]);

			// I'm not 100% sure, but this seems to be the case:
			stream.seek(-1, SeekPos.End);
			stream.readBlock(cast(void*)&trk, 1);
			tag.track = trk;
			// No max tracks provided in ID3v1:
			tag.tracks = 0;

			// Who knows after this?
			return tag;

		} else {

			// No ID3v1 or ID3v2 tag found.

			// Please note that I do NOT throw an exception here,
			// since it is NOT an error that an ID3 tag is not found.
			// Some files simply do not contain them.  Also, there is
			// the possibility that the stream being scanned is NOT
			// an MP3 file.

			return null;

		}
	}

	return null;
}

// A dummy test:
debug {
	int main(char[][] args) {
		// Check command arguments:
		if (args.length < 2) {
			printf("%.*s <filename.mp3>\n", args[0]);
			return 1;
		}

		// Open the mp3 file:
		File	mp3 = new File(args[1]);

		// Search for ID3 tag (v2 first, then v1):
		ID3Tag*	tag = readID3Tag(mp3);
		if (!(tag is null)) {
			printf("ID3v%d tag\n", tag.id3version);
			printf("Title:      '%.*s'\n", tag.title);
			printf("Arist:      '%.*s'\n", tag.artist);
			printf("Album:      '%.*s'\n", tag.album);
			printf("Album Year: %d\n", tag.year);
			printf("Track:      %d/%d\n", tag.track, tag.tracks);
			printf("Genre:      '%.*s'\n", tag.genre);
		} else {
			printf("No ID3 tag found\n");
		}

		// Close that mp3 file:
		mp3.close();

		// That's it!
		return 0;
	}
}
