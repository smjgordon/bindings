/* Converted to D from ./magick/timer.h by htod */
module timer;

align(1):
/*
  Copyright (C) 2003 GraphicsMagick Group
  Copyright (C) 2002 ImageMagick Studio
 
  This program is covered by multiple licenses, which are described in
  Copyright.txt. You should have received a copy of Copyright.txt with this
  package; otherwise see http://www.graphicsmagick.org/www/Copyright.html.
 
  ImageMagick Timer Methods.
*/
//C     #ifndef _MAGICK_TIMER_H
//C     #define _MAGICK_TIMER_H

//C     #if defined(__cplusplus) || defined(c_plusplus)
//C     extern "C" {
//C     #endif

/*
  Enum declarations.
*/
//C     typedef enum
//C     {
//C       UndefinedTimerState,
//C       StoppedTimerState,
//C       RunningTimerState
//C     } TimerState;
enum
{
    UndefinedTimerState,
    StoppedTimerState,
    RunningTimerState,
}
extern (C):
alias int TimerState;

/*
  Typedef declarations.
*/
//C     typedef struct _Timer
//C     {
//C       double
//C         start,
//C         stop,
//C         total;
//C     } Timer;
struct _Timer
{
    double start;
    double stop;
    double total;
}
alias _Timer Timer;

//C     typedef struct _TimerInfo
//C     {
//C       Timer
//C         user,
//C         elapsed;

//C       TimerState
//C         state;

//C       unsigned long
//C         signature;
//C     } TimerInfo;
struct _TimerInfo
{
    Timer user;
    Timer elapsed;
    TimerState state;
    uint signature;
}
alias _TimerInfo TimerInfo;

/*
  Timer methods.
*/
//C     extern double
//C       GetElapsedTime(TimerInfo *),
double  GetElapsedTime(TimerInfo *);
//C       GetUserTime(TimerInfo *),
double  GetUserTime(TimerInfo *);
//C       GetTimerResolution(void);
double  GetTimerResolution();

//C     extern unsigned int
//C       ContinueTimer(TimerInfo *);
uint  ContinueTimer(TimerInfo *);

//C     extern void
//C       GetTimerInfo(TimerInfo *),
void  GetTimerInfo(TimerInfo *);
//C       ResetTimer(TimerInfo *);
void  ResetTimer(TimerInfo *);

//C     #if defined(__cplusplus) || defined(c_plusplus)
//C     }
//C     #endif

//C     #endif
