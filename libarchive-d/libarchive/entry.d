//
// libarchive modules for D
// Written by Anders Bergh <anders1@gmail.com>
// Released into the public domain
//

module libarchive.entry;

import libarchive.types;

extern (C):

struct archive_entry;

const int AE_IFMT = 0170000;
const int AE_IFREG = 0100000;
const int AE_IFLNK = 0120000;
const int AE_IFSOCK = 0140000;
const int AE_IFCHR = 0020000;
const int AE_IFBLK = 0060000;
const int AE_IFDIR = 0040000;
const int AE_IFIFO = 0010000;

archive_entry* archive_entry_clear(archive_entry*);
archive_entry* archive_entry_clone(archive_entry*);
void archive_entry_free(archive_entry*);
archive_entry* archive_entry_new();

time_t archive_entry_atime(archive_entry*);
int archive_entry_atime_nsec(archive_entry*);
time_t archive_entry_ctime(archive_entry*);
int archive_entry_ctime_nsec(archive_entry*);
dev_t archive_entry_dev(archive_entry*);
dev_t archive_entry_devmajor(archive_entry*);
dev_t archive_entry_devminor(archive_entry*);
mode_t archive_entry_filetype(archive_entry*);
void archive_entry_fflags(archive_entry*, uint *set, uint *clear);
char* archive_entry_fflags_text(archive_entry*);
gid_t archive_entry_gid(archive_entry*);
char* archive_entry_gname(archive_entry*);
wchar* archive_entry_gname_w(archive_entry*);
char* archive_entry_hardlink(archive_entry*);
wchar* archive_entry_hardlink_w(archive_entry*);
ino_t archive_entry_ino(archive_entry*);
mode_t archive_entry_mode(archive_entry*);
time_t archive_entry_mtime(archive_entry*);
int archive_entry_mtime_nsec(archive_entry*);
uint archive_entry_nlink(archive_entry*);
char* archive_entry_pathname(archive_entry*);
wchar* archive_entry_pathname_w(archive_entry*);
dev_t archive_entry_rdev(archive_entry*);
dev_t archive_entry_rdevmajor(archive_entry*);
dev_t archive_entry_rdevminor(archive_entry*);
int64_t archive_entry_size(archive_entry*);
char* archive_entry_strmode(archive_entry*);
char* archive_entry_symlink(archive_entry*);
wchar* archive_entry_symlink_w(archive_entry*);
uid_t archive_entry_uid(archive_entry*);
char* archive_entry_uname(archive_entry*);
wchar* archive_entry_uname_w(archive_entry*);

void archive_entry_set_atime(archive_entry*, time_t, int);
void archive_entry_set_ctime(archive_entry*, time_t, int);
void archive_entry_set_dev(archive_entry*, dev_t);
void archive_entry_set_devmajor(archive_entry*, dev_t);
void archive_entry_set_devminor(archive_entry*, dev_t);
void archive_entry_set_filetype(archive_entry*, uint);
void archive_entry_set_fflags(archive_entry*, uint set, uint clear);
wchar* archive_entry_copy_fflags_text_w(archive_entry*, wchar*);
void	archive_entry_set_gid(archive_entry*, gid_t);
void	archive_entry_set_gname(archive_entry*, char*);
void	archive_entry_copy_gname(archive_entry*, char*);
void	archive_entry_copy_gname_w(archive_entry*, wchar*);
void	archive_entry_set_hardlink(archive_entry*, char*);
void	archive_entry_copy_hardlink(archive_entry*, char*);
void	archive_entry_copy_hardlink_w(archive_entry*, wchar*);
void	archive_entry_set_ino(archive_entry*, uint);
void	archive_entry_set_link(archive_entry*, char*);
void	archive_entry_set_mode(archive_entry*, mode_t);
void	archive_entry_set_mtime(archive_entry*, time_t, long);
void	archive_entry_set_nlink(archive_entry*, uint);
void	archive_entry_set_pathname(archive_entry*, char*);
void	archive_entry_copy_pathname(archive_entry*, char*);
void	archive_entry_copy_pathname_w(archive_entry*, wchar*);
void	archive_entry_set_perm(archive_entry*, mode_t);
void	archive_entry_set_rdev(archive_entry*, dev_t);
void	archive_entry_set_rdevmajor(archive_entry*, dev_t);
void	archive_entry_set_rdevminor(archive_entry*, dev_t);
void	archive_entry_set_size(archive_entry*, int64_t);
void	archive_entry_set_symlink(archive_entry*, char*);
void	archive_entry_copy_symlink(archive_entry*, char*);
void	archive_entry_copy_symlink_w(archive_entry*, wchar*);
void	archive_entry_set_uid(archive_entry*, uid_t);
void	archive_entry_set_uname(archive_entry*, char*);
void	archive_entry_copy_uname(archive_entry*, char*);
void	archive_entry_copy_uname_w(archive_entry*, wchar*);

stat_t* archive_entry_stat(archive_entry*);
void archive_entry_copy_stat(archive_entry*, stat_t*);

const int ARCHIVE_ENTRY_ACL_EXECUTE = 1;
const int ARCHIVE_ENTRY_ACL_WRITE = 2;
const int ARCHIVE_ENTRY_ACL_READ = 4;

const int ARCHIVE_ENTRY_ACL_TYPE_ACCESS = 256;
const int ARCHIVE_ENTRY_ACL_TYPE_DEFAULT = 512;

const int ARCHIVE_ENTRY_ACL_USER = 10001;
const int ARCHIVE_ENTRY_ACL_USER_OBJ = 10002;
const int ARCHIVE_ENTRY_ACL_GROUP = 10003;
const int ARCHIVE_ENTRY_ACL_GROUP_OBJ = 10004;
const int ARCHIVE_ENTRY_ACL_MASK = 10005;
const int ARCHIVE_ENTRY_ACL_OTHER = 10006;

void archive_entry_acl_clear(archive_entry*);
void archive_entry_acl_add_entry(archive_entry*, int type, int permset, int tag, int qual, char* name);
void archive_entry_acl_add_entry_w(archive_entry*, int type, int permset, int tag, int qual, wchar* name);

int archive_entry_acl_reset(archive_entry*, int want_type);
int archive_entry_acl_next(archive_entry*, int want_type, int* type, int* permset, int* tag, int* qual, char** name);
int archive_entry_acl_next_w(archive_entry*, int want_type, int* type, int* permset, int* tag, int* qual, wchar** name);

const int ARCHIVE_ENTRY_ACL_STYLE_EXTRA_ID = 1024;
const int ARCHIVE_ENTRY_ACL_STYLE_MARK_DEFAULT = 2048;
wchar* archive_entry_acl_text_w(archive_entry*, int flags);

int archive_entry_acl_count(archive_entry*, int want_type);

int __archive_entry_acl_parse_w(archive_entry*, wchar*, int type);

void archive_entry_xattr_clear(archive_entry*);
void archive_entry_xattr_add_entry(archive_entry*, char* name, void* value, size_t size);

int archive_entry_xattr_count(archive_entry*);
int archive_entry_xattr_reset(archive_entry*);
int archive_entry_xattr_next(archive_entry*, char** name, void** value, size_t*);

struct archive_entry_linkresolver;

archive_entry_linkresolver* archive_entry_linkresolver_new();
void archive_entry_linkresolver_free(archive_entry_linkresolver*);
char* archive_entry_linkresolve(archive_entry_linkresolver*, archive_entry*);
