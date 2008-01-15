//
// libarchive modules for D
// Written by Anders Bergh <anders1@gmail.com>
// Released into the public domain
//

module libarchive.libarchive;

import libarchive.entry;
import libarchive.types;

// For rebuild (and DSSS)
version (build)
{
	version (Posix)
		pragma(link, "archive");
	version (Windows)
		pragma(link, "archive2");
}

extern (C):

const char[] ARCHIVE_LIBRARY_VERSION = "libarchive 2.3.3";
char* archive_version();

const int ARCHIVE_VERSION_STAMP = 2003003;
int archive_version_stamp();

const int ARCHIVE_API_VERSION = (ARCHIVE_VERSION_STAMP / 1000000);
int archive_api_version();

const int ARCHIVE_API_FEATURE = ((ARCHIVE_VERSION_STAMP / 1000) % 1000);
int archive_api_feature();

const int ARCHIVE_BYTES_PER_RECORD = 512;
const int ARCHIVE_DEFAULT_BYTES_PER_BLOCK = 10240;

struct archive;

const int ARCHIVE_EOF = 1;
const int ARCHIVE_OK = 0;
const int ARCHIVE_RETRY = -10;
const int ARCHIVE_WARN = -20;
const int ARCHIVE_FAILED = -25;
const int ARCHIVE_FATAL = -30;

alias ssize_t function(archive*, void* _client_data, void** _buffer) archive_read_callback;
static if (ARCHIVE_API_VERSION < 2)
	alias ssize_t function(archive*, void* _client_data, size_t request) archive_skip_callback;
else
	alias ssize_t function(archive*, void* _client_data, off_t request) archive_skip_callback;
alias ssize_t function(archive*, void* _client_data, void* _buffer, size_t _length) archive_write_callback;
alias int function(archive*, void* _client_data) archive_open_callback;
alias int function(archive*, void* _client_data) archive_close_callback;

const int ARCHIVE_COMPRESSION_NONE = 0;
const int ARCHIVE_COMPRESSION_GZIP = 1;
const int ARCHIVE_COMPRESSION_BZIP2 = 2;
const int ARCHIVE_COMPRESSION_COMPRESS = 3;
const int ARCHIVE_COMPRESSION_PROGRAM = 4;

const int ARCHIVE_FORMAT_BASE_MASK = 0xff0000;
const int ARCHIVE_FORMAT_CPIO = 0x10000;
const int ARCHIVE_FORMAT_CPIO_POSIX = (ARCHIVE_FORMAT_CPIO | 1);
const int ARCHIVE_FORMAT_CPIO_BIN_LE = (ARCHIVE_FORMAT_CPIO | 2);
const int ARCHIVE_FORMAT_CPIO_BIN_BE = (ARCHIVE_FORMAT_CPIO | 3);
const int ARCHIVE_FORMAT_CPIO_SVR4_NOCRC = (ARCHIVE_FORMAT_CPIO | 4);
const int ARCHIVE_FORMAT_CPIO_SVR4_CRC = (ARCHIVE_FORMAT_CPIO | 5);
const int ARCHIVE_FORMAT_SHAR = 0x20000;
const int ARCHIVE_FORMAT_SHAR_BASE = (ARCHIVE_FORMAT_SHAR | 1);
const int ARCHIVE_FORMAT_SHAR_DUMP = (ARCHIVE_FORMAT_SHAR | 2);
const int ARCHIVE_FORMAT_TAR = 0x30000;
const int ARCHIVE_FORMAT_TAR_USTAR = (ARCHIVE_FORMAT_TAR | 1);
const int ARCHIVE_FORMAT_TAR_PAX_INTERCHANGE = (ARCHIVE_FORMAT_TAR | 2);
const int ARCHIVE_FORMAT_TAR_PAX_RESTRICTED = (ARCHIVE_FORMAT_TAR | 3);
const int ARCHIVE_FORMAT_TAR_GNUTAR = (ARCHIVE_FORMAT_TAR | 4);
const int ARCHIVE_FORMAT_ISO9660 = 0x40000;
const int ARCHIVE_FORMAT_ISO9660_ROCKRIDGE = (ARCHIVE_FORMAT_ISO9660 | 1);
const int ARCHIVE_FORMAT_ZIP = 0x50000;
const int ARCHIVE_FORMAT_EMPTY = 0x60000;
const int ARCHIVE_FORMAT_AR = 0x70000;
const int ARCHIVE_FORMAT_AR_GNU = (ARCHIVE_FORMAT_AR | 1);
const int ARCHIVE_FORMAT_AR_BSD = (ARCHIVE_FORMAT_AR | 2);
const int ARCHIVE_FORMAT_MTREE = 0x80000;
const int ARCHIVE_FORMAT_MTREE_V1 = (ARCHIVE_FORMAT_MTREE | 1);
const int ARCHIVE_FORMAT_MTREE_V2 = (ARCHIVE_FORMAT_MTREE | 2);

archive* archive_read_new();

int archive_read_support_compression_all(archive*);
int archive_read_support_compression_bzip2(archive*);
int archive_read_support_compression_compress(archive*);
int archive_read_support_compression_gzip(archive*);
int archive_read_support_compression_none(archive*);
int archive_read_support_compression_program(archive*, char* command);

int archive_read_support_format_all(archive*);
int archive_read_support_format_ar(archive*);
int archive_read_support_format_cpio(archive*);
int archive_read_support_format_empty(archive*);
int archive_read_support_format_gnutar(archive*);
int archive_read_support_format_iso9660(archive*);
int archive_read_support_format_mtree(archive*);
int archive_read_support_format_tar(archive*);
int archive_read_support_format_zip(archive*);

int archive_read_open(archive*, void* _client_data, archive_open_callback, archive_read_callback, archive_close_callback);
int archive_read_open2(archive*, void* _client_data, archive_open_callback, archive_read_callback, archive_skip_callback, archive_close_callback);

int archive_read_open_filename(archive*, char* _filename, size_t _block_size);
int archive_read_open_file(archive*, char* _filename, size_t _block_size);
int archive_read_open_memory(archive*, void* buff, size_t size);
int archive_read_open_memory2(archive* a, void* buff, size_t size, size_t read_size);
int archive_read_open_fd(archive*, int _fd, size_t _block_size);
int archive_read_open_FILE(archive*, void* /*FILE**/ _file);
int archive_read_next_header(archive*, archive_entry**);
int64_t archive_read_header_position(archive*);
ssize_t archive_read_data(archive*, void*, size_t);
int archive_read_data_block(archive* a, void** buff, size_t* size, off_t* offset);

int archive_read_data_skip(archive*);
int archive_read_data_into_buffer(archive*, void* buffer, ssize_t len);
int archive_read_data_into_fd(archive*, int fd);

const int ARCHIVE_EXTRACT_OWNER = 1;
const int ARCHIVE_EXTRACT_PERM = 2;
const int ARCHIVE_EXTRACT_TIME = 4;
const int ARCHIVE_EXTRACT_NO_OVERWRITE = 8;
const int ARCHIVE_EXTRACT_UNLINK = 16;
const int ARCHIVE_EXTRACT_ACL = 32;
const int ARCHIVE_EXTRACT_FFLAGS = 64;
const int ARCHIVE_EXTRACT_XATTR = 128;
const int ARCHIVE_EXTRACT_SECURE_SYMLINKS = 256;
const int ARCHIVE_EXTRACT_SECURE_NODOTDOT = 512;
const int ARCHIVE_EXTRACT_NO_AUTODIR = 1024;
const int ARCHIVE_EXTRACT_NO_OVERWRITE_NEWER = 2048;

int archive_read_extract(archive*, archive_entry*, int flags);
void archive_read_extract_set_progress_callback(archive*, void function(void*), void* _user_data);

void archive_read_extract_set_skip_file(archive*, dev_t, ino_t);

int archive_read_close(archive*);

static if (ARCHIVE_API_VERSION > 1)
	int archive_read_finish(archive*);
else
	void archive_read_finish(archive*);

archive* archive_write_new();
int archive_write_set_bytes_per_block(archive*, int bytes_per_block);
int archive_write_get_bytes_per_block(archive*);
int archive_write_set_bytes_in_last_block(archive*, int bytes_in_last_block);
int archive_write_get_bytes_in_last_block(archive*);

int archive_write_set_skip_file(archive*, dev_t, ino_t);

int archive_write_set_compression_bzip2(archive*);
int archive_write_set_compression_gzip(archive*);
int archive_write_set_compression_none(archive*);
int archive_write_set_compression_program(archive*, char* cmd);
int archive_write_set_format(archive*, int format_code);
int archive_write_set_format_by_name(archive*, char* name);
int archive_write_set_format_ar_bsd(archive*);
int archive_write_set_format_ar_svr4(archive*);
int archive_write_set_format_cpio(archive*);
int archive_write_set_format_cpio_newc(archive*);
int archive_write_set_format_pax(archive*);
int archive_write_set_format_pax_restricted(archive*);
int archive_write_set_format_shar(archive*);
int archive_write_set_format_shar_dump(archive*);
int archive_write_set_format_ustar(archive*);
int archive_write_open(archive*, void*, archive_open_callback, archive_write_callback, archive_close_callback);
int archive_write_open_fd(archive*, int _fd);
int archive_write_open_filename(archive*, char* _file);
int archive_write_open_file(archive*, char* _file);
int archive_write_open_FILE(archive*, void* /*FILE**/);
int archive_write_open_memory(archive*, void* _buffer, size_t _buffSize, size_t* _used);

int archive_write_header(archive*, archive_entry*);
static if (ARCHIVE_API_VERSION > 1)
	ssize_t archive_write_data(archive*, void*, size_t);
else
	int archive_write_data(archive*, void*, size_t);
ssize_t archive_write_data_block(archive*, void*, size_t, off_t);
int archive_write_finish_entry(archive*);
int archive_write_close(archive*);
static if (ARCHIVE_API_VERSION > 1)
	int archive_write_finish(archive*);
else
	void archive_write_finish(archive*);

archive* archive_write_disk_new();
int archive_write_disk_set_skip_file(archive*, dev_t, ino_t);
int archive_write_disk_set_options(archive*, int flags);

int archive_write_disk_set_standard_lookup(archive*);

int archive_write_disk_set_group_lookup(archive*, void* private_data, gid_t function(void*, char* gname, gid_t gid) loookup, void function(void*) cleanup);
int archive_write_disk_set_user_lookup(archive*, void* private_data, uid_t function(void*, char* gname, uid_t gid) loookup, void function(void*) cleanup);

int64_t archive_position_compressed(archive*);
int64_t archive_position_uncompressed(archive*);

char* archive_compression_name(archive*);
int archive_compression(archive*);
int archive_errno(archive*);
char* archive_error_string(archive*);
char* archive_format_name(archive*);
int archive_format(archive*);
void archive_clear_error(archive*);
void archive_set_error(archive*, int _err, char *fmt, ...);
void archive_copy_error(archive* dest, archive* src);
