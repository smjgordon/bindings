/******************************************************************************

  pthreads.d:    Posix threads module for the D programming language
  
  Based on Linux C headers by Xavier Leroy

  D module by John Reimer 2004-12-01
		 
  -------------------------------------------------------------------
  
  2004-12-04 ADDED:  Semaphores and fixed module formatting - John Reimer
  
  ****************************************************************************/
    
module std.c.unix.pthread;

version(USE_UNIX98)
{
	version = USE_UNIX98_OR_XOPEN2K;
}

version(USE_XOPEN2K)
{
	version = USE_UNIX98_OR_XOPEN2K;
}

typedef uint __time_t;
	
struct timespec
{
	__time_t tv_sec;
	uint	 tv_nsec;
}

/******************************************** 

  bits/pthreadtypes

*********************************************/

/* pthread types */

struct _pthread_fastlock
{
	int __status;
	int __spinlock;
}

// TODO: _pthread_descr_struct* _pthread_descr;
// How do I declare _pthread_desc_struct* for a 
// structure that isn't defined in the headers?
// For now, I just define the symbol.  I guess 
// that _pthread_descr_struct is never referenced
// except by pointer so there should be no issue
// here.

extern(C) struct _pthread_descr_struct {};

typedef _pthread_descr_struct* _pthread_descr;

struct sched_param 
{
	int __sched_priority;
}

struct pthread_attr_t
{
	int 	__detachstate;
	int 	__schedpolicy;
	sched_param __schedparam;
	int 	__inheritsched;
	int 	__scope;
	size_t 	__guardsize;
	int 	__stackaddr_set;
	void*	__stackaddr;
	size_t 	__stacksize;
}

// Not sure if it should be uint or long
typedef long __pthread_cond_align_t;

struct pthread_cond_t 
{
	_pthread_fastlock __c_lock;
	_pthread_descr	  __c_waiting;
	char[48 - _pthread_fastlock.sizeof
		- _pthread_descr.sizeof
		- __pthread_cond_align_t.sizeof] __padding;
	__pthread_cond_align_t __align;
}

struct pthread_condattr_t
{
	int __dummy;
}

typedef uint pthread_key_t;

struct pthread_mutex_t
{
	int 		__m_reserved;
	int 		__m_count;
	_pthread_descr	__m_owner;
	int 		__m_kind;
	_pthread_fastlock __m_lock;
}

struct pthread_mutexattr_t
{
	int __mutexkind;
}

typedef int pthread_once_t;

version(USE_UNIX98_OR_XOPEN2K)
{
	struct pthread_rwlock_t
	{
		_pthread_fastlock __rw_lock;
		int 		  __rw_readers;
		_pthread_descr	  __rw_writer;
		_pthread_descr	  __rw_read_waiting;
		_pthread_descr	  __rw_write_waiting;
		int		  __rw_pshared;
	}

	struct pthread_rwlockattr_t
	{
		int __lockkind;
		int __pshared;
	}
}

version(USE_XOPEN2K)
{
	typedef int pthread_spinlock_t;

	struct pthread_barrier_t
	{
		_pthread_fastlock __ba_lock;
		int 		  __ba_required;
		int 		  __ba_present;
		_pthread_descr 	  __va_waiting;
	}

	struct pthread_barrierattr_t
	{
		int __pshared;
	}
}

typedef uint pthread_t;

/************************************************

   End of bits/pthreadtypes

*************************************************/


/************************************************

  pthread start
  
************************************************/

enum
{
	PTHREAD_CREATE_JOINABLE,
	PTHREAD_CREATE_DETACHED
}
        
enum
{
	PTHREAD_INHERIT_SCHED,
	PTHREAD_EXPLICIT_SCHED
}

enum
{
	PTHREAD_SCOPE_SYSTEM,
	PTHREAD_SCOPE_PROCESS
}

enum 
{
	PTHREAD_MUTEX_TIMED_NP,
	PTHREAD_MUTEX_RECURSIVE_NP,
	PTHREAD_MUTEX_ERRORCHECK_NP,
	PTHREAD_MUTEX_ADAPTIVE_NP
}

version(USE_GNU) enum 
{
	PTHREAD_MUTEX_FAST_NP = PTHREAD_MUTEX_ADAPTIVE_NP	
}

version(USE_UNIX98) enum 
{	
	PTHREAD_MUTEX_NORMAL = PTHREAD_MUTEX_TIMED_NP,
	PTHREAD_MUTEX_RECURSIVE = PTHREAD_MUTEX_RECURSIVE_NP,
	PTHREAD_MUTEX_ERRORCHECK = PTHREAD_MUTEX_ERRORCHECK_NP,
	PTHREAD_MUTEX_DEFAULT = PTHREAD_MUTEX_NORMAL
}

enum
{
	PTHREAD_PROCESS_PRIVATE,
	PTHREAD_PROCESS_SHARED
}


version(USE_UNIX98_OR_XOPEN2K) enum
{
	PTHREAD_RWLOCK_PREFER_READER_NP,
	PTHREAD_RWLOCK_PREFER_WRITER_NP,
	PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP,
	PTHREAD_RWLOCK_DEFAULT_NP = PTHREAD_RWLOCK_PREFER_WRITER_NP
}

const int PTHREAD_ONCE_INIT = 0;

version(XOPEN2K) const int PTHREAD_BARRIER_SERIAL_THREAD = -1;

/* Cleanup buffers */
	
struct _pthread_cleanup_buffer
{
	void function(void*) __routine;		// Function to call.
	void *		 __arg;			// Its argument. 
	int   		 __canceltype;		// Saved cancellation type.
	_pthread_cleanup_buffer *__prev;	// Chaining of cleanup functions
}

/* Canellation */

enum
{
	PTHREAD_CANCEL_ENABLE,
	PTHREAD_CANCEL_DISABLE
}

enum
{
	PTHREAD_CANCEL_DEFERRED,
	PTHREAD_CANCEL_ASYNCHRONOUS
}

const void* PTHREAD_CANCELED = cast(void*)-1;


extern(C)
{

int	pthread_create(	pthread_t*, pthread_attr_t*, void* function(void*),void*);
pthread_t 	pthread_self ();
int	pthread_equal( pthread_t, pthread_t );
void	pthread_exit( void* );
int	pthread_join( pthread_t, void** );
int	pthread_detach( pthread_t );

int	pthread_attr_init( pthread_attr_t* );
int	pthread_attr_destroy( pthread_attr_t* );
int	pthread_attr_setdetachstate( pthread_attr_t*, int );
int	pthread_attr_getdetachstate( pthread_attr_t*, int* );
int	pthread_attr_setschedparam( pthread_attr_t*, sched_param* );
int	pthread_attr_getschedparam( pthread_attr_t*, sched_param* );
int	pthread_attr_setschedpolicy( pthread_attr_t*, int );
int	pthread_attr_getschedpolicy( pthread_attr_t*, int* );
int	pthread_attr_setinheritsched( pthread_attr_t*, int );
int	pthread_attr_getinheritsched( pthread_attr_t*, int* );
int	pthread_attr_setscope( pthread_attr_t*, int );    
int	pthread_attr_getscope( pthread_attr_t*, int* );

version(USE_UNIX98) 
{				    
	int	pthread_attr_setguardsize( pthread_attr_t*, size_t );
	int	pthread_attr_getguardsize( pthread_attr_t*, size_t* );
}

int	pthread_attr_setstackaddr( pthread_attr_t*, void* );
int	pthread_attr_getstackaddr( pthread_attr_t*, void** );
					  
version(USE_XOPEN2K)
{
	int	pthread_attr_setstack( pthread_attr_t*, void*, size_t );
	int 	pthread_attr_getstack( pthread_attr_t*, void**, size_t* );
}

int	pthread_attr_setstacksize( pthread_attr_t*, size_t );
int	pthread_attr_getstacksize( pthread_attr_t*, size_t* );
				
version(USE_GNU)
{
	int	pthread_getattr_np ( pthread_t, pthread_attr_t* );
}

int	pthread_setschedparam( pthread_t, int, sched_param* );
int	pthread_getschedparam( pthread_t, int*, sched_param* );
				       
version(USE_UNIX98)
{
	int	pthread_getconcurrency();
	int	pthread_setconcurrency( int );
}

version(USE_GNU)
{
	int	pthread_yield();
}

int	pthread_mutex_init( pthread_mutex_t*, pthread_mutexattr_t* );
int	pthread_mutex_destroy( pthread_mutex_t* );
int	pthread_mutex_trylock( pthread_mutex_t* );
int	pthread_mutex_lock( pthread_mutex_t* );

version(USE_XOPEN2K) 
{
	int	pthread_mutex_timedlock( pthread_mutex_t*, timespec* );
}

int	pthread_mutex_unlock( pthread_mutex_t* );

int	pthread_mutexattr_init( pthread_mutexattr_t* );
int	pthread_mutexattr_destroy( pthread_mutexattr_t* );
int	pthread_mutexattr_getpshared( pthread_mutexattr_t*, int* );
int	pthread_mutexattr_setpshared( pthread_mutexattr_t*, int );
					      
version(USE_UNIX98) 
{
	int	pthread_mutexattr_settype( pthread_mutexattr_t*, int );
	int	pthread_mutexattr_gettype( pthread_mutexattr_t*, int* );
}

int	pthread_cond_init( pthread_cond_t*, pthread_condattr_t* );
int	pthread_cond_destroy( pthread_cond_t* );
int	pthread_cond_signal( pthread_cond_t* );
int	pthread_cond_wait( pthread_cond_t*, pthread_mutex_t* );
int	pthread_cond_timewait( pthread_cond_t*, pthread_mutex_t*, timespec* );
	
int	pthread_condattr_init( pthread_condattr_t* );
int	pthread_condattr_destroy( pthread_condattr_t* );
int	pthread_condattr_getpshared( pthread_condattr_t*, int* );
int	pthread_condattr_setpshared( pthread_condattr_t*, int );
					
version (USE_UNIX98_OR_XOPEN2K)
{
	int 	pthread_rwlock_init( pthread_rwlock_t*,pthread_rwlockattr_t* );
	int 	pthread_rwlock_destroy( pthread_rwlock_t* );
	int	pthread_rwlock_rdlock( pthread_rwlock_t* );
	int	pthread_rwlock_tryrdlock( pthread_rwlock_t* );
	int	pthread_rwlock_wrlock( pthread_rwlock_t* );
	int	pthread_rwlock_trywrlock( pthread_rwlock_t* );
	int	pthread_rwlock_unlock( pthread_rwlock_t* );

	int	pthread_rwlockattr_init( pthread_rwlockattr_t* );
	int	pthread_rwlockattr_destroy( pthread_rwlockattr_t* );
	int	pthread_rwlockattr_getpshared( pthread_rwlockattr_t*, int* );
	int	pthread_rwlockattr_setpshared( pthread_rwlockattr_t*, int );
	int	pthread_rwlockattr_getkind_np( pthread_rwlockattr_t*, int* );
	int	pthread_rwlockattr_setkind_np( pthread_rwlockattr_t*, int );
}

version(USE_XOPEN2K) 
{
	int	pthread_rwlock_timedrdlock( pthread_rwlock_t*, timespec* );
	int	pthread_rwlock_timedwrlock( pthread_rwlock_t*, timespec* );

/*  Spinlocks -- IEEE Std. 1003.1j-2000. */

	int	pthread_spin_init( pthread_spinlock_t*, int );
	int	pthread_spin_destroy( pthread_spinlock_t* );
	int	pthread_spin_lock( pthread_spinlock_t* );
	int	pthread_spin_trylock( pthread_spinlock_t* );
	int	pthread_spin_unlock( pthread_spinlock_t* );

/* Barriers -- IEEE Std. 1003.1j-2000. */

	int	pthread_barrier_init( pthread_barrier_t*, pthread_barrierattr_t*, uint );
	int	pthread_barrier_destory( pthread_barrier_t* );
	int	pthread_barrerattr_init( pthread_barrierattr_t* );
	int	pthread_barrerattr_destroy( pthread_barrierattr_t* );
	int	pthread_barrierattr_getpshared( pthread_barrierattr_t*,int* );
	int	pthread_barrierattr_setpshared( pthread_barrierattr_t*,int );
	int	pthread_barrier_wait( pthread_barrier_t* __barrier );	
}

int	pthread_key_create( pthread_key_t*, void (*)(void*) );
int	pthread_key_delete( pthread_key_t );
int	pthread_setspecific( pthread_key_t, void* );
void*	pthread_getspecific( pthread_key_t );

int	pthread_once( pthread_once_t*, void (*)() );

int	pthread_setcancelstate( int, int* );
int	pthread_setcanceltype( int, int* );
int	pthread_cancel( pthread_t );
void	pthread_testcancel();
void	_pthread_cleanup_push( _pthread_cleanup_buffer*,void function(void*),void* );
void	_pthread_cleanup_pop( _pthread_cleanup_buffer*, int );

	
version(USE_XOPEN2K) 
{
	typedef int	__clockid_t;	

	int	pthread_getcpuclockid( pthread_t, __clockid_t* );
}

version(USE_UNIX98) 
{
	struct __sigset_t
	{
		uint[1024/(8*uint.sizeof)] __val;
	}

	int	pthread_sigmask( int, __sigset_t*, __sigset_t* );
	int	pthread_kill( pthread_t, int );
}

int	pthread_atfork( void function(), void function(), void function() );
void	pthread_kill_other_threads_np();

} // extern(C)      

/***************************************************************

	Semaphores -- part of pthreads

 ***************************************************************/

/* System specific semaphore definition. */

version(linux)
{
	struct sem_t
	{
		_pthread_fastlock __sem_lock;
		int 		  __sem_value;
		_pthread_descr	  __sem_waiting;
	}
} 

else 
{
	struct sem_t{};  // other versions should implement
}

const sem_t* SEM_FAILED = null;
const uint   SEM_VALUE_MAX = 2_147_483_647;

/* Semaphores */

extern(C)
{
int	sem_init( sem_t *, int );
int	sem_destory( sem_t* );
sem_t* sem_open( char*, int, ... );
int	sem_close( sem_t* );
int	sem_unlink( char* );
int	sem_wait( sem_t* );
	
version(USE_XOPEN2K)
	int sem_timedwait(sem_t*, timespec* );

int	sem_trywait( sem_t* );
int	sem_post( sem_t* );
int	sem_getvalue( sem_t*, int* );

} // extern(C)

	







   